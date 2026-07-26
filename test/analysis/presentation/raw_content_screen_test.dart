import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qriora/features/analysis/presentation/raw_content_screen.dart';
import 'package:qriora/features/scanner/domain/scan_payload.dart';
import 'package:qriora/features/scanner/domain/scan_record.dart';
import 'package:qriora/features/scanner/domain/scan_source.dart';
import 'package:qriora/features/scanner/domain/scan_content_type.dart';
import 'package:qriora/features/scanner/domain/barcode_format.dart';
import 'package:qriora/features/scanner/presentation/scanner_screen.dart';
import 'package:qriora/features/analysis/domain/analysis_result.dart';
import 'package:qriora/features/analysis/domain/risk_severity.dart';
import 'package:qriora/features/analysis/domain/analysis_method.dart';

ScanRecord _buildScanRecord(String id, String rawValue) {
  return ScanRecord(
    id: id,
    payload: ScanPayload(
      rawValue: rawValue,
      normalisedValue: rawValue,
      contentType: ScanContentType.httpsUrl,
      barcodeFormat: BarcodeFormat.unknown,
    ),
    source: ScanSource.camera,
    scannedAt: DateTime.now(),
    analysis: AnalysisResult(
      overallSeverity: RiskSeverity.informational,
      findings: const [],
      summary: 'Test summary',
      limitations: const [],
      analysisVersion: '1.0.0',
      analysisMethod: AnalysisMethod.deterministicRule,
      usedNetworkLookup: false,
    ),
    isFavourite: false,
    isSensitive: false,
    analysisVersion: '1.0.0',
  );
}

void main() {
  group('RawContentScreen', () {
    testWidgets('shows not found when scan record is missing', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const RawContentScreen(scanId: 'nonexistent'),
          ),
        ),
      );

      expect(find.text('Scan record not found.'), findsOneWidget);
    });

    testWidgets('displays raw and normalised values when record exists',
        (tester) async {
      final record = _buildScanRecord('test-id', 'https://example.com');

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            lastScanResultProvider.overrideWith((ref) => record),
          ],
          child: const MaterialApp(
            home: RawContentScreen(scanId: 'test-id'),
          ),
        ),
      );

      expect(find.text('Raw value'), findsOneWidget);
      expect(find.text('Normalised value'), findsOneWidget);
      expect(find.text('https://example.com'), findsNWidgets(2));
    });

    testWidgets('displays app bar with correct title', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const RawContentScreen(scanId: 'test'),
          ),
        ),
      );

      expect(find.text('Raw content'), findsOneWidget);
    });
  });
}
