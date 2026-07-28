import 'package:flutter_test/flutter_test.dart';
import 'package:qriora/features/analysis/domain/risk_analyser.dart';
import 'package:qriora/features/scanner/domain/scan_payload.dart';
import 'package:qriora/features/scanner/domain/scan_content_type.dart';
import 'package:qriora/features/scanner/domain/barcode_format.dart';
import 'package:qriora/features/analysis/domain/extracted_entity.dart';

void main() {
  late RiskAnalyser analyser;

  setUp(() {
    analyser = RiskAnalyser();
  });

  ScanPayload _makeUrlPayload(String url, {List<ExtractedEntity>? entities, ScanContentType? contentType}) {
    final domain = Uri.tryParse(url)?.host ?? '';
    return ScanPayload(
      rawValue: url,
      normalisedValue: url,
      contentType: contentType ?? ScanContentType.httpsUrl,
      barcodeFormat: BarcodeFormat.qrCode,
      entities: entities ?? [ExtractedEntity(type: ExtractedEntityType.domain, value: domain)],
    );
  }

  group('Punycode/IDN detection', () {
    test('flags punycode domain', () {
      final payload = _makeUrlPayload(
        'https://xn--e1afmkfd.example.com',
      );
      final result = analyser.analyse(payload);
      expect(
        result.findings.any((f) => f.ruleId == 'url-punycode-domain'),
        isTrue,
      );
    });

    test('does not flag normal domain', () {
      final payload = _makeUrlPayload('https://example.com');
      final result = analyser.analyse(payload);
      expect(
        result.findings.any((f) => f.ruleId == 'url-punycode-domain'),
        isFalse,
      );
    });
  });

  group('Localhost/private IP detection', () {
    test('flags localhost', () {
      final payload = _makeUrlPayload('http://localhost:8080', contentType: ScanContentType.httpUrl);
      final result = analyser.analyse(payload);
      expect(
        result.findings.any((f) => f.ruleId == 'url-localhost-or-private-ip'),
        isTrue,
      );
    });

    test('flags 127.0.0.1', () {
      final payload = _makeUrlPayload('http://127.0.0.1/admin', contentType: ScanContentType.httpUrl);
      final result = analyser.analyse(payload);
      expect(
        result.findings.any((f) => f.ruleId == 'url-localhost-or-private-ip'),
        isTrue,
      );
    });

    test('flags 192.168.x.x', () {
      final payload = _makeUrlPayload('http://192.168.1.1/router', contentType: ScanContentType.httpUrl);
      final result = analyser.analyse(payload);
      expect(
        result.findings.any((f) => f.ruleId == 'url-localhost-or-private-ip'),
        isTrue,
      );
    });

    test('flags 10.x.x.x', () {
      final payload = _makeUrlPayload('http://10.0.0.1/internal', contentType: ScanContentType.httpUrl);
      final result = analyser.analyse(payload);
      expect(
        result.findings.any((f) => f.ruleId == 'url-localhost-or-private-ip'),
        isTrue,
      );
    });

    test('flags 172.16.x.x', () {
      final payload = _makeUrlPayload('http://172.16.0.1/portal', contentType: ScanContentType.httpUrl);
      final result = analyser.analyse(payload);
      expect(
        result.findings.any((f) => f.ruleId == 'url-localhost-or-private-ip'),
        isTrue,
      );
    });

    test('does not flag public IP', () {
      final payload = _makeUrlPayload('https://203.0.113.1/page');
      final result = analyser.analyse(payload);
      expect(
        result.findings.any((f) => f.ruleId == 'url-localhost-or-private-ip'),
        isFalse,
      );
    });
  });

  group('WEP encryption detection', () {
    test('flags WEP as high risk', () {
      final payload = ScanPayload(
        rawValue: 'WIFI:T:WEP;S:TestNet;P:password;;',
        normalisedValue: 'WIFI:T:WEP;S:TestNet;P:password;;',
        contentType: ScanContentType.wifi,
        barcodeFormat: BarcodeFormat.qrCode,
        entities: [
          ExtractedEntity(type: ExtractedEntityType.ssid, value: 'TestNet'),
          ExtractedEntity(type: ExtractedEntityType.encryptionType, value: 'WEP'),
          ExtractedEntity(type: ExtractedEntityType.password, value: 'password', isSensitive: true),
        ],
      );
      final result = analyser.analyse(payload);
      expect(
        result.findings.any((f) => f.ruleId == 'wifi-wep-encryption' && f.severity.name == 'highRisk'),
        isTrue,
      );
    });

    test('does not flag WPA', () {
      final payload = ScanPayload(
        rawValue: 'WIFI:T:WPA;S:TestNet;P:password;;',
        normalisedValue: 'WIFI:T:WPA;S:TestNet;P:password;;',
        contentType: ScanContentType.wifi,
        barcodeFormat: BarcodeFormat.qrCode,
        entities: [
          ExtractedEntity(type: ExtractedEntityType.ssid, value: 'TestNet'),
          ExtractedEntity(type: ExtractedEntityType.encryptionType, value: 'WPA'),
          ExtractedEntity(type: ExtractedEntityType.password, value: 'password', isSensitive: true),
        ],
      );
      final result = analyser.analyse(payload);
      expect(
        result.findings.any((f) => f.ruleId == 'wifi-wep-encryption'),
        isFalse,
      );
    });
  });

  group('SMS embedded URL detection', () {
    test('flags SMS with URL in body', () {
      final payload = ScanPayload(
        rawValue: 'smsto:1234567890:Click https://evil.com/steal',
        normalisedValue: 'smsto:1234567890:Click https://evil.com/steal',
        contentType: ScanContentType.sms,
        barcodeFormat: BarcodeFormat.qrCode,
        entities: [
          ExtractedEntity(type: ExtractedEntityType.phoneNumber, value: '1234567890'),
          ExtractedEntity(type: ExtractedEntityType.body, value: 'Click https://evil.com/steal'),
        ],
      );
      final result = analyser.analyse(payload);
      expect(
        result.findings.any((f) => f.ruleId == 'sms-embedded-url'),
        isTrue,
      );
    });

    test('does not flag SMS without URL', () {
      final payload = ScanPayload(
        rawValue: 'smsto:1234567890:Hello there',
        normalisedValue: 'smsto:1234567890:Hello there',
        contentType: ScanContentType.sms,
        barcodeFormat: BarcodeFormat.qrCode,
        entities: [
          ExtractedEntity(type: ExtractedEntityType.phoneNumber, value: '1234567890'),
          ExtractedEntity(type: ExtractedEntityType.body, value: 'Hello there'),
        ],
      );
      final result = analyser.analyse(payload);
      expect(
        result.findings.any((f) => f.ruleId == 'sms-embedded-url'),
        isFalse,
      );
    });
  });

  group('Contact embedded URL detection', () {
    test('flags contact with URL in note', () {
      final payload = ScanPayload(
        rawValue: 'BEGIN:VCARD\nVERSION:3.0\nFN:Test\nNOTE:Visit https://evil.com\nEND:VCARD',
        normalisedValue: 'BEGIN:VCARD\nVERSION:3.0\nFN:Test\nNOTE:Visit https://evil.com\nEND:VCARD',
        contentType: ScanContentType.vCard,
        barcodeFormat: BarcodeFormat.qrCode,
        entities: [
          ExtractedEntity(type: ExtractedEntityType.contactName, value: 'Test'),
          ExtractedEntity(type: ExtractedEntityType.note, value: 'Visit https://evil.com'),
        ],
      );
      final result = analyser.analyse(payload);
      expect(
        result.findings.any((f) => f.ruleId == 'contact-embedded-url'),
        isTrue,
      );
    });
  });

  group('Calendar embedded URL detection', () {
    test('flags calendar event with URL in description', () {
      final payload = ScanPayload(
        rawValue: 'BEGIN:VEVENT\nSUMMARY:Meeting\nDESCRIPTION:Join https://evil.com/meeting\nEND:VEVENT',
        normalisedValue: 'BEGIN:VEVENT\nSUMMARY:Meeting\nDESCRIPTION:Join https://evil.com/meeting\nEND:VEVENT',
        contentType: ScanContentType.calendarEvent,
        barcodeFormat: BarcodeFormat.qrCode,
        entities: [
          ExtractedEntity(type: ExtractedEntityType.eventTitle, value: 'Meeting'),
          ExtractedEntity(type: ExtractedEntityType.eventDescription, value: 'Join https://evil.com/meeting'),
          ExtractedEntity(type: ExtractedEntityType.eventStart, value: '20240101T100000'),
          ExtractedEntity(type: ExtractedEntityType.eventEnd, value: '20240101T110000'),
        ],
      );
      final result = analyser.analyse(payload);
      expect(
        result.findings.any((f) => f.ruleId == 'calendar-embedded-url'),
        isTrue,
      );
    });

    test('flags calendar event with no end time', () {
      final payload = ScanPayload(
        rawValue: 'BEGIN:VEVENT\nSUMMARY:Meeting\nDTSTART:20240101T100000\nEND:VEVENT',
        normalisedValue: 'BEGIN:VEVENT\nSUMMARY:Meeting\nDTSTART:20240101T100000\nEND:VEVENT',
        contentType: ScanContentType.calendarEvent,
        barcodeFormat: BarcodeFormat.qrCode,
        entities: [
          ExtractedEntity(type: ExtractedEntityType.eventTitle, value: 'Meeting'),
          ExtractedEntity(type: ExtractedEntityType.eventStart, value: '20240101T100000'),
        ],
      );
      final result = analyser.analyse(payload);
      expect(
        result.findings.any((f) => f.ruleId == 'calendar-no-end-time'),
        isTrue,
      );
    });
  });
}
