import 'package:flutter_test/flutter_test.dart';
import 'package:qriora/features/scanner/domain/payload_parser.dart';
import 'package:qriora/features/scanner/domain/scan_content_type.dart';
import 'package:qriora/features/analysis/domain/extracted_entity.dart';

void main() {
  late PayloadParser parser;

  setUp(() {
    parser = PayloadParser();
  });

  group('PayloadParser', () {
    test('parses HTTPS URL', () {
      final payload = parser.parse(
        'https://example.com/path',
        contentType: ScanContentType.httpsUrl,
      );
      expect(payload.contentType, ScanContentType.httpsUrl);
      expect(payload.rawValue, 'https://example.com/path');
      expect(payload.entities, isNotEmpty);
      expect(payload.entities.any((e) => e.type == ExtractedEntityType.url), isTrue);
    });

    test('parses email', () {
      final payload = parser.parse(
        'user@example.com',
        contentType: ScanContentType.email,
      );
      expect(payload.entities.any((e) => e.type == ExtractedEntityType.emailAddress), isTrue);
    });

    test('parses mailto', () {
      final payload = parser.parse(
        'mailto:user@example.com',
        contentType: ScanContentType.mailto,
      );
      expect(payload.entities.any((e) => e.type == ExtractedEntityType.emailAddress), isTrue);
    });

    test('parses tel', () {
      final payload = parser.parse(
        'tel:+1234567890',
        contentType: ScanContentType.tel,
      );
      expect(payload.entities.any((e) => e.type == ExtractedEntityType.phoneNumber), isTrue);
    });

    test('parses Wi-Fi', () {
      final payload = parser.parse(
        'WIFI:T:WPA;S:MyNetwork;P:password;;',
        contentType: ScanContentType.wifi,
      );
      expect(payload.entities.any((e) => e.type == ExtractedEntityType.ssid), isTrue);
      expect(payload.entities.any((e) => e.type == ExtractedEntityType.password), isTrue);
      expect(payload.isSensitive, isTrue);
    });

    test('parses vCard', () {
      final payload = parser.parse(
        'BEGIN:VCARD\nVERSION:3.0\nFN:John Doe\nTEL:+1234567890\nEND:VCARD',
        contentType: ScanContentType.vCard,
      );
      expect(payload.entities.any((e) => e.type == ExtractedEntityType.contactName), isTrue);
      expect(payload.entities.any((e) => e.type == ExtractedEntityType.phone), isTrue);
    });

    test('parses geo coordinates', () {
      final payload = parser.parse(
        'geo:37.7749,-122.4194',
        contentType: ScanContentType.geoCoordinates,
      );
      expect(payload.entities.any((e) => e.type == ExtractedEntityType.latitude), isTrue);
      expect(payload.entities.any((e) => e.type == ExtractedEntityType.longitude), isTrue);
    });

    test('parses SMS', () {
      final payload = parser.parse(
        'sms:+1234567890?body=Hello',
        contentType: ScanContentType.sms,
      );
      expect(payload.entities.any((e) => e.type == ExtractedEntityType.phoneNumber), isTrue);
    });

    test('marks Wi-Fi as sensitive', () {
      final payload = parser.parse(
        'WIFI:T:WPA;S:MyNetwork;P:password;;',
        contentType: ScanContentType.wifi,
      );
      expect(payload.isSensitive, isTrue);
    });

    test('does not mark plain text as sensitive', () {
      final payload = parser.parse(
        'Hello, world!',
        contentType: ScanContentType.plainText,
      );
      expect(payload.isSensitive, isFalse);
    });
  });
}
