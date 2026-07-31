import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart' as mobile_scanner;

import '../domain/scan_payload.dart';
import '../domain/scan_source.dart';
import '../domain/barcode_format.dart';
import '../domain/payload_classifier.dart';
import '../domain/payload_parser.dart';
import '../domain/content_normaliser.dart';
import '../domain/entity_extractor.dart' as scanner_extractor;
import '../domain/permission_service.dart';
import '../../analysis/domain/risk_analyser.dart';
import '../../analysis/domain/action_resolver.dart';
import '../../analysis/domain/analysis_result.dart';
import '../../analysis/domain/suggested_action.dart';
import '../domain/scan_record.dart';
import '../../settings/domain/retention_policy.dart';
import '../../../core/services/providers.dart';
import '../../../core/services/qriora_logger.dart';
import '../../../core/database/qriora_database.dart' hide ScanRecord;
import '../../../app/theme/design_tokens.dart';
import '../../../app/accessibility/accessibility_helpers.dart';
import 'scanner_guidance_overlay.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' show Value;

/// Provider for the scan processing pipeline.
final scanPipelineProvider = Provider<ScanPipeline>((ref) {
  return ScanPipeline();
});

/// Provider for the last scan result.
final lastScanResultProvider = StateProvider<ScanRecord?>((ref) => null);

/// Provider for the permission service.
final permissionServiceProvider = Provider<PermissionService>((ref) {
  return PermissionService();
});

/// Scanner screen — the primary scanning interface.
class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ConsumerState<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen>
    with WidgetsBindingObserver {
  late mobile_scanner.MobileScannerController _controller;
  final PermissionService _permissionService = PermissionService();

  bool _isProcessing = false;
  bool _isPaused = false;
  bool _torchEnabled = false;
  String? _lastScannedValue;
  DateTime? _lastScanTime;
  CameraPermissionStatus _permissionStatus = CameraPermissionStatus.denied;
  bool _cameraReady = false;
  String? _cameraError;

  static const _duplicateSuppressionWindow = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = mobile_scanner.MobileScannerController(
      detectionSpeed: mobile_scanner.DetectionSpeed.noDuplicates,
    );
    _checkPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        _controller.stop();
        QrioraLogger.info('scanner', 'Camera stopped (lifecycle: ${state.name})');
      case AppLifecycleState.resumed:
        if (_permissionStatus == CameraPermissionStatus.granted && !_isPaused) {
          _controller.start().then((_) {
            QrioraLogger.info('scanner', 'Camera resumed (lifecycle: resumed)');
          }).catchError((e) {
            QrioraLogger.error('scanner', 'Failed to resume camera', error: e);
            setState(() => _cameraError = 'Could not restart the camera. Try returning to the scan tab.');
          });
        }
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        break;
    }
  }

  Future<void> _checkPermission() async {
    final status = await _permissionService.checkCameraPermission();
    if (mounted) {
      setState(() => _permissionStatus = status);
      if (status == CameraPermissionStatus.granted) {
        _startCamera();
      } else if (status == CameraPermissionStatus.denied) {
        _requestPermission();
      }
    }
  }

  Future<void> _requestPermission() async {
    final status = await _permissionService.requestCameraPermission();
    if (mounted) {
      setState(() => _permissionStatus = status);
      if (status == CameraPermissionStatus.granted) {
        _startCamera();
      }
    }
  }

  Future<void> _startCamera() async {
    try {
      await _controller.start();
      if (mounted) {
        setState(() {
          _cameraReady = true;
          _cameraError = null;
        });
      }
    } catch (e) {
      QrioraLogger.error('scanner', 'Failed to start camera', error: e);
      if (mounted) {
        setState(() => _cameraError = 'Could not start the camera. Please try again.');
      }
    }
  }

  void _togglePause() {
    setState(() => _isPaused = !_isPaused);
    if (_isPaused) {
      _controller.stop();
    } else {
      _controller.start();
    }
  }

  void _toggleTorch() {
    _controller.toggleTorch();
    setState(() => _torchEnabled = !_torchEnabled);
  }

  Future<void> _scanFromGallery() async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      if (mounted) setState(() => _isProcessing = true);

      final path = image.path;
      final result = await _controller.analyzeImage(path);

      if (result == null || result.barcodes.isEmpty) {
        if (mounted) {
          setState(() => _isProcessing = false);
          _showNoCodeFoundDialog();
        }
        return;
      }

      _processBarcode(result.barcodes.first, ScanSource.imageFile);
    } catch (e) {
      QrioraLogger.error('scanner', 'Gallery scan failed', error: e);
      if (mounted) {
        setState(() => _isProcessing = false);
        _showErrorDialog('Could not read the selected image. Please try a clearer photo.');
      }
    }
  }

  void _showNoCodeFoundDialog() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('No code found'),
        content: const Text('Qriora could not find a QR code or barcode in the selected image. Try a clearer photo with the code centred.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Scanning problem'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onDetect(mobile_scanner.BarcodeCapture capture) {
    final barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    _processBarcode(barcodes.first, ScanSource.camera);
  }

  void _processBarcode(mobile_scanner.Barcode barcode, ScanSource source) {
    final rawValue = barcode.rawValue;
    if (rawValue == null || rawValue.isEmpty) {
      QrioraLogger.warning('scanner', 'Barcode detected but raw value was null');
      return;
    }

    if (rawValue.length > QrioraDesignTokens.maxPayloadLength) {
      QrioraLogger.warning('scanner', 'Payload exceeds max length (${rawValue.length} chars)');
      if (mounted) {
        _showErrorDialog('This code contains too much data for Qriora to analyse safely.');
      }
      return;
    }

    final settings = ref.read(settingsProvider);

    if (settings.deduplicateScans) {
      final now = DateTime.now();
      if (rawValue == _lastScannedValue &&
          _lastScanTime != null &&
          now.difference(_lastScanTime!) < _duplicateSuppressionWindow) {
        return;
      }
      _lastScannedValue = rawValue;
      _lastScanTime = now;
    }

    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    _triggerFeedback(settings);

    final pipeline = ref.read(scanPipelineProvider);
    final record = pipeline.process(
      rawValue,
      barcodeFormat: _mapBarcodeFormat(barcode.format),
      source: source,
    );

    ref.read(lastScanResultProvider.notifier).state = record;
    _maybePersist(record);

    if (mounted) {
      setState(() => _isProcessing = false);
      context.push('/result/${record.id}');
    }
  }

  void _triggerFeedback(settings) {
    if (settings.hapticFeedback) {
      HapticFeedback.mediumImpact();
    }
    if (settings.soundFeedback) {
      SystemSound.play(SystemSoundType.click);
    }
  }

  Future<void> _maybePersist(ScanRecord record) async {
    final settings = ref.read(settingsProvider);
    if (settings.privateMode || !settings.saveHistory) return;
    if (settings.retentionPolicy.period == RetentionPeriod.never) return;

    try {
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
    } catch (e) {
      QrioraLogger.error('scanner', 'Failed to persist scan record', error: e);
    }
  }

  BarcodeFormat _mapBarcodeFormat(mobile_scanner.BarcodeFormat mobileScannerFormat) {
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
    final parts = <String>[];
    parts.add('overallSeverity=${analysis.overallSeverity.name}');
    parts.add('summary=${analysis.summary}');
    parts.add('analysisVersion=${analysis.analysisVersion}');
    parts.add('analysisMethod=${analysis.analysisMethod.name}');
    parts.add('findingsCount=${analysis.findings.length}');
    return parts.join('|');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan'),
        actions: [
          if (_cameraReady && _permissionStatus == CameraPermissionStatus.granted) ...[
            IconButton(
              icon: Icon(_torchEnabled ? Icons.flash_on : Icons.flash_off),
              onPressed: _toggleTorch,
              tooltip: 'Toggle torch',
            ),
            IconButton(
              icon: const Icon(Icons.cameraswitch),
              onPressed: () => _controller.switchCamera(),
              tooltip: 'Switch camera',
            ),
            IconButton(
              icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
              onPressed: _togglePause,
              tooltip: _isPaused ? 'Resume scanning' : 'Pause scanning',
            ),
          ],
          IconButton(
            icon: const Icon(Icons.photo_library),
            onPressed: _scanFromGallery,
            tooltip: 'Scan from gallery',
          ),
          IconButton(
            icon: const Icon(Icons.keyboard),
            onPressed: () => context.push('/manual-entry'),
            tooltip: 'Manual entry',
          ),
        ],
      ),
      body: QrioraFocusTraversalPolicy.wrap(_buildBody()),
    );
  }

  Widget _buildBody() {
    if (_cameraError != null) {
      return _CameraErrorState(
        message: _cameraError!,
        onRetry: () {
          setState(() => _cameraError = null);
          _startCamera();
        },
      );
    }

    switch (_permissionStatus) {
      case CameraPermissionStatus.granted:
        if (!_cameraReady) {
          return const Center(child: CircularProgressIndicator());
        }
        return _buildScannerView();
      case CameraPermissionStatus.denied:
        return _PermissionDeniedState(
          onRequestPermission: _requestPermission,
        );
      case CameraPermissionStatus.permanentlyDenied:
        return _PermissionPermanentlyDeniedState(
          onOpenSettings: () => _permissionService.openAppSettings(),
        );
      case CameraPermissionStatus.restricted:
        return _PermissionDeniedState(
          onRequestPermission: _requestPermission,
        );
    }
  }

  Widget _buildScannerView() {
    return Stack(
      children: [
        mobile_scanner.MobileScanner(
          controller: _controller,
          onDetect: _onDetect,
        ),
        _ScannerOverlay(
          isProcessing: _isProcessing,
          isPaused: _isPaused,
        ),
        ScannerGuidanceOverlay(
          isPaused: _isPaused,
          isProcessing: _isProcessing,
        ),
        if (_isProcessing)
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: Semantics(
                liveRegion: true,
                label: 'Analysing scanned code',
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 8),
                        Text('Analysing...'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Overlay for the scanner with viewfinder and processing indicator.
class _ScannerOverlay extends StatelessWidget {
  final bool isProcessing;
  final bool isPaused;

  const _ScannerOverlay({required this.isProcessing, required this.isPaused});

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
              height: QrioraDesignTokens.scanAreaSize,
              width: QrioraDesignTokens.scanAreaSize,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(QrioraDesignTokens.scanAreaRadius),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Permission denied state — shows explanation and request button.
class _PermissionDeniedState extends StatelessWidget {
  final VoidCallback onRequestPermission;

  const _PermissionDeniedState({required this.onRequestPermission});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: 'Camera permission required. Qriora needs camera access to scan codes.',
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(QrioraDesignTokens.spaceLg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.camera_alt_outlined, size: 64, color: Colors.grey),
              const SizedBox(height: QrioraDesignTokens.spaceMd),
              Text(
                'Camera permission needed',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
            ),
            const SizedBox(height: QrioraDesignTokens.spaceSm),
            Text(
              'Qriora needs camera access to scan QR codes and barcodes. '
              'No photos or videos are stored.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: QrioraDesignTokens.spaceLg),
            FilledButton.icon(
              onPressed: onRequestPermission,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Grant camera access'),
            ),
          ],
        ),
      ),
    ),
    );
  }
}

/// Permanently denied state — guides user to system settings.
class _PermissionPermanentlyDeniedState extends StatelessWidget {
  final VoidCallback onOpenSettings;

  const _PermissionPermanentlyDeniedState({required this.onOpenSettings});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(QrioraDesignTokens.spaceLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.settings, size: 64, color: Colors.grey),
            const SizedBox(height: QrioraDesignTokens.spaceMd),
            Text(
              'Camera access blocked',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: QrioraDesignTokens.spaceSm),
            Text(
              'Camera permission was permanently denied. '
              'Please enable it in your device settings to scan codes.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: QrioraDesignTokens.spaceLg),
            FilledButton.icon(
              onPressed: onOpenSettings,
              icon: const Icon(Icons.settings),
              label: const Text('Open settings'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Camera error state — shows error message and retry button.
class _CameraErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _CameraErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(QrioraDesignTokens.spaceLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: QrioraDesignTokens.spaceMd),
            Text(
              'Camera problem',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: QrioraDesignTokens.spaceSm),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: QrioraDesignTokens.spaceLg),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try again'),
            ),
          ],
        ),
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
    final normalised = _normaliser.normalise(rawValue);
    var contentType = _classifier.classify(normalised, barcodeFormat: barcodeFormat);
    var payload = _parser.parse(
      rawValue,
      contentType: contentType,
      barcodeFormat: barcodeFormat,
    );
    final additionalEntities = _extractor.extract(payload);
    payload = payload.copyWith(entities: additionalEntities);
    final analysis = _analyser.analyse(payload);

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
