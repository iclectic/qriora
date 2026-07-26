import 'package:flutter_test/flutter_test.dart';
import 'package:qriora/features/analysis/domain/action_resolver.dart';
import 'package:qriora/features/scanner/domain/scan_payload.dart';
import 'package:qriora/features/scanner/domain/scan_content_type.dart';
import 'package:qriora/features/scanner/domain/barcode_format.dart';
import 'package:qriora/features/analysis/domain/suggested_action.dart';

void main() {
  late ActionResolver resolver;

  setUp(() {
    resolver = ActionResolver();
  });

  ScanPayload buildPayload(
    String value, {
    ScanContentType contentType = ScanContentType.httpsUrl,
  }) {
    return ScanPayload(
      rawValue: value,
      normalisedValue: value,
      contentType: contentType,
      barcodeFormat: BarcodeFormat.unknown,
    );
  }

  group('ActionResolver', () {
    test('resolves openUrl for HTTPS URLs', () {
      final payload = buildPayload('https://example.com');
      final actions = resolver.resolve(payload);
      expect(actions.any((a) => a.type == SuggestedActionType.openUrl), isTrue);
    });

    test('resolves composeEmail for email', () {
      final payload = buildPayload(
        'user@example.com',
        contentType: ScanContentType.email,
      );
      final actions = resolver.resolve(payload);
      expect(actions.any((a) => a.type == SuggestedActionType.composeEmail), isTrue);
    });

    test('resolves callPhone for tel', () {
      final payload = buildPayload(
        'tel:+1234567890',
        contentType: ScanContentType.tel,
      );
      final actions = resolver.resolve(payload);
      expect(actions.any((a) => a.type == SuggestedActionType.callPhone), isTrue);
    });

    test('resolves joinWifi for Wi-Fi', () {
      final payload = buildPayload(
        'WIFI:T:WPA;S:MyNetwork;P:password;;',
        contentType: ScanContentType.wifi,
      );
      final actions = resolver.resolve(payload);
      expect(actions.any((a) => a.type == SuggestedActionType.joinWifi), isTrue);
    });

    test('resolves saveContact for vCard', () {
      final payload = buildPayload(
        'BEGIN:VCARD\nVERSION:3.0\nFN:John\nEND:VCARD',
        contentType: ScanContentType.vCard,
      );
      final actions = resolver.resolve(payload);
      expect(actions.any((a) => a.type == SuggestedActionType.saveContact), isTrue);
    });

    test('resolves openInMap for geo', () {
      final payload = buildPayload(
        'geo:37.7749,-122.4194',
        contentType: ScanContentType.geoCoordinates,
      );
      final actions = resolver.resolve(payload);
      expect(actions.any((a) => a.type == SuggestedActionType.openInMap), isTrue);
    });

    test('always includes rescan and dismiss', () {
      final payload = buildPayload('https://example.com');
      final actions = resolver.resolve(payload);
      expect(actions.any((a) => a.type == SuggestedActionType.rescan), isTrue);
      expect(actions.any((a) => a.type == SuggestedActionType.dismiss), isTrue);
    });

    test('marks primary action as isPrimary', () {
      final payload = buildPayload('https://example.com');
      final actions = resolver.resolve(payload);
      expect(actions.any((a) => a.isPrimary), isTrue);
    });

    test('resolves copy for plain text', () {
      final payload = buildPayload(
        'Hello, world!',
        contentType: ScanContentType.plainText,
      );
      final actions = resolver.resolve(payload);
      expect(actions.any((a) => a.type == SuggestedActionType.copy), isTrue);
    });
  });
}
