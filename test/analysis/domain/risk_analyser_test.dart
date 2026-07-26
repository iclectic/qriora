import 'package:flutter_test/flutter_test.dart';
import 'package:qriora/features/analysis/domain/risk_analyser.dart';
import 'package:qriora/features/analysis/domain/risk_severity.dart';
import 'package:qriora/features/analysis/domain/analysis_result.dart';
import 'package:qriora/features/scanner/domain/scan_payload.dart';
import 'package:qriora/features/scanner/domain/scan_content_type.dart';
import 'package:qriora/features/scanner/domain/barcode_format.dart';
import 'package:qriora/features/analysis/domain/extracted_entity.dart';
import 'package:qriora/features/analysis/domain/analysis_method.dart';

void main() {
  late RiskAnalyser analyser;

  setUp(() {
    analyser = RiskAnalyser();
  });

  ScanPayload buildPayload(
    String value, {
    ScanContentType contentType = ScanContentType.httpsUrl,
    List<ExtractedEntity> entities = const [],
    bool isSensitive = false,
  }) {
    return ScanPayload(
      rawValue: value,
      normalisedValue: value,
      contentType: contentType,
      barcodeFormat: BarcodeFormat.unknown,
      entities: entities,
      isSensitive: isSensitive,
    );
  }

  group('RiskAnalyser', () {
    test('returns informational for safe HTTPS URL', () {
      final payload = buildPayload('https://example.com');
      final result = analyser.analyse(payload);
      expect(result.overallSeverity, RiskSeverity.informational);
      expect(result.findings, isEmpty);
    });

    test('flags HTTP URL as caution', () {
      final payload = buildPayload(
        'http://example.com',
        contentType: ScanContentType.httpUrl,
      );
      final result = analyser.analyse(payload);
      expect(result.overallSeverity, RiskSeverity.caution);
      expect(
        result.findings.any((f) => f.ruleId == 'http-insecure'),
        isTrue,
      );
    });

    test('flags URL shortener as caution', () {
      final payload = buildPayload(
        'https://bit.ly/abc123',
        entities: [ExtractedEntity(type: ExtractedEntityType.domain, value: 'bit.ly')],
      );
      final result = analyser.analyse(payload);
      expect(
        result.findings.any((f) => f.ruleId == 'url-shortener'),
        isTrue,
      );
    });

    test('flags IP address URL as caution', () {
      final payload = buildPayload(
        'https://192.168.1.1/login',
        entities: [ExtractedEntity(type: ExtractedEntityType.domain, value: '192.168.1.1')],
      );
      final result = analyser.analyse(payload);
      expect(
        result.findings.any((f) => f.ruleId == 'url-ip-host'),
        isTrue,
      );
    });

    test('flags embedded credentials in URL as high risk', () {
      final payload = buildPayload('https://user:pass@example.com');
      final result = analyser.analyse(payload);
      expect(result.overallSeverity, RiskSeverity.highRisk);
      expect(
        result.findings.any((f) => f.ruleId == 'url-embedded-credentials'),
        isTrue,
      );
    });

    test('flags Wi-Fi as caution (sensitive data)', () {
      final payload = buildPayload(
        'WIFI:T:WPA;S:MyNetwork;P:password;;',
        contentType: ScanContentType.wifi,
        isSensitive: true,
      );
      final result = analyser.analyse(payload);
      expect(
        result.findings.any((f) => f.ruleId == 'wifi-credentials-embedded'),
        isTrue,
      );
    });

    test('flags deep link as caution', () {
      final payload = buildPayload(
        'myapp://path',
        contentType: ScanContentType.deepLink,
      );
      final result = analyser.analyse(payload);
      expect(
        result.findings.any((f) => f.ruleId == 'deep-link-unknown-app'),
        isTrue,
      );
    });

    test('includes limitations in result', () {
      final payload = buildPayload('https://example.com');
      final result = analyser.analyse(payload);
      expect(result.limitations, isNotEmpty);
    });

    test('includes analysis version in result', () {
      final payload = buildPayload('https://example.com');
      final result = analyser.analyse(payload);
      expect(result.analysisVersion, isNotEmpty);
    });

    test('uses deterministic rule method', () {
      final payload = buildPayload('https://example.com');
      final result = analyser.analyse(payload);
      expect(result.analysisMethod.label, 'Deterministic rule');
    });

    test('does not claim content is safe', () {
      final payload = buildPayload('https://example.com');
      final result = analyser.analyse(payload);
      // The summary must include a disclaimer, not claim safety
      expect(result.summary.toLowerCase(), contains('does not mean'));
      expect(result.summary.toLowerCase(), isNot(contains('guaranteed safe')));
    });
  });
}
