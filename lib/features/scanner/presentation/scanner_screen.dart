import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart' as mobile_scanner;

import '../domain/scan_payload.dart';
import '../domain/scan_source.dart';
import '../domain/barcode_format.dart';
import '../domain/payload_classifier.dart';
import '../domain/payload_parser.dart';
import '../domain/content_normaliser.dart';
import '../domain/entity_extractor.dart' as scanner_extractor;
import '../../analysis/domain/risk_analyser.dart';
import '../../analysis/domain/action_resolver.dart';
import '../../analysis/domain/analysis_result.dart';
import '../../analysis/domain/suggested_action.dart';
import '../domain/scan_record.dart';
import '../../settings/domain/retention_policy.dart';
import '../../../core/services/providers.dart';
import '../../../core/database/qriora_database.dart' hide ScanRecord;
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' show Value;

/// Provider for the scan processing pipeline.
final scanPipelineProvider = Provider<ScanPipeline>((ref) {
  return ScanPipeline();
});

/// Provider for the last scan result.
final lastScanResultProvider = StateProvider<ScanRecord?>((ref) => null);

/// Scanner screen — the primary scanning interface.
class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ConsumerState<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen> {
  final mobile_scanner.MobileScannerController _controller = mobile_scanner.MobileScannerController();
  bool _isProcessing = false;
  String? _lastScannedValue;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => _controller.toggleTorch(),
            tooltip: 'Toggle torch',
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: () => _controller.switchCamera(),
            tooltip: 'Switch camera',
          ),
          IconButton(
            icon: const Icon(Icons.keyboard),
            onPressed: () => context.push('/manual-entry'),
            tooltip: 'Manual entry',
          ),
        ],
      ),
      body: Stack(
        children: [
          mobile_scanner.MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
          ),
          _ScannerOverlay(
            isProcessing: _isProcessing,
          ),
        ],
      ),
    );
  }

  void _onDetect(mobile_scanner.BarcodeCapture capture) {
    final barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final barcode = barcodes.first;
    final rawValue = barcode.rawValue;
    if (rawValue == null || rawValue.isEmpty) return;

    // Deduplicate consecutive scans
    final settings = ref.read(settingsProvider);
    if (settings.deduplicateScans && rawValue == _lastScannedValue) return;
    _lastScannedValue = rawValue;

    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    // Process the scan
    final pipeline = ref.read(scanPipelineProvider);
    final record = pipeline.process(
      rawValue,
      barcodeFormat: _mapBarcodeFormat(barcode.format),
      source: ScanSource.camera,
    );

    // Store the result
    ref.read(lastScanResultProvider.notifier).state = record;

    // Persist if allowed
    _maybePersist(record);

    // Navigate to result
    if (mounted) {
      setState(() => _isProcessing = false);
      context.go('/scan');
      // Use a temporary ID for in-memory navigation
      _navigateToResult(record);
    }
  }

  void _navigateToResult(ScanRecord record) {
    // For camera scans, we pass the record via the provider and
    // navigate to a result route using the record ID.
    // The result screen will read from the provider if the ID
    // is not found in the database.
    context.push('/result/${record.id}');
  }

  Future<void> _maybePersist(ScanRecord record) async {
    final settings = ref.read(settingsProvider);
    if (settings.privateMode || !settings.saveHistory) return;
    if (settings.retentionPolicy.period == RetentionPeriod.never) return;

    final db = ref.read(databaseProvider);
    await db.insertScanRecord(
      ScanRecordsCompanion.insert(
        id: record.id,
        rawValue: record.payload.rawValue,
        normalisedValue: record.payload.normalisedValue,
        contentType: record.payload.contentType.dbValue,
        barcodeFormat: record.payload.barcodeFormat.dbValue,
        source: record.source.dbValue,
        scannedAt: record.scannedAt,
        analysisJson: _encodeAnalysis(record.analysis),
        isFavourite: Value(record.isFavourite),
        note: Value(record.note),
        isSensitive: Value(record.isSensitive),
        analysisVersion: record.analysisVersion,
      ),
    );
  }

  BarcodeFormat _mapBarcodeFormat(mobile_scanner.BarcodeFormat mobileScannerFormat) {
    // mobile_scanner uses its own BarcodeFormat enum
    // We map by name for resilience
    try {
      return BarcodeFormat.values.firstWhere(
        (e) => e.name == mobileScannerFormat.name,
        orElse: () => BarcodeFormat.unknown,
      );
    } catch (_) {
      return BarcodeFormat.unknown;
    }
  }

  String _encodeAnalysis(AnalysisResult analysis) {
    // Simple encoding for storage — in production, use json_serializable
    final parts = <String>[];
    parts.add('overallSeverity=${analysis.overallSeverity.name}');
    parts.add('summary=${analysis.summary}');
    parts.add('analysisVersion=${analysis.analysisVersion}');
    parts.add('analysisMethod=${analysis.analysisMethod.name}');
    parts.add('findingsCount=${analysis.findings.length}');
    return parts.join('|');
  }
}

/// Overlay for the scanner with viewfinder and processing indicator.
class _ScannerOverlay extends StatelessWidget {
  final bool isProcessing;

  const _ScannerOverlay({required this.isProcessing});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        Colors.black.withValues(alpha: 0.3),
        BlendMode.srcOut,
      ),
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The scan processing pipeline that orchestrates classification,
/// parsing, entity extraction, risk analysis, and action resolution.
class ScanPipeline {
  final PayloadClassifier _classifier = PayloadClassifier();
  final ContentNormaliser _normaliser = ContentNormaliser();
  final PayloadParser _parser = PayloadParser();
  final scanner_extractor.EntityExtractor _extractor =
      scanner_extractor.EntityExtractor();
  final RiskAnalyser _analyser = RiskAnalyser();
  final ActionResolver _actionResolver = ActionResolver();
  final Uuid _uuid = const Uuid();

  /// Processes a raw scanned value and returns a complete [ScanRecord].
  ScanRecord process(
    String rawValue, {
    BarcodeFormat barcodeFormat = BarcodeFormat.unknown,
    required ScanSource source,
  }) {
    // 1. Normalise
    final normalised = _normaliser.normalise(rawValue);

    // 2. Classify
    var contentType = _classifier.classify(normalised, barcodeFormat: barcodeFormat);

    // 3. Parse
    var payload = _parser.parse(
      rawValue,
      contentType: contentType,
      barcodeFormat: barcodeFormat,
    );

    // 4. Extract additional entities
    final additionalEntities = _extractor.extract(payload);
    payload = payload.copyWith(entities: additionalEntities);

    // 5. Analyse
    final analysis = _analyser.analyse(payload);

    // 6. Build record (actions are resolved lazily via resolve())
    return ScanRecord(
      id: _uuid.v4(),
      payload: payload,
      source: source,
      scannedAt: DateTime.now(),
      analysis: analysis,
      isFavourite: false,
      isSensitive: payload.isSensitive,
      analysisVersion: analysis.analysisVersion,
    );
  }

  /// Resolves suggested actions for a payload.
  List<SuggestedAction> resolve(ScanPayload payload) =>
      _actionResolver.resolve(payload);
}
