import 'package:flutter_test/flutter_test.dart';
import 'package:qriora/features/scanner/domain/payload_classifier.dart';
import 'package:qriora/features/scanner/domain/scan_content_type.dart';
import 'package:qriora/features/scanner/domain/barcode_format.dart';

void main() {
  late PayloadClassifier classifier;

  setUp(() {
    classifier = PayloadClassifier();
  });

  group('PayloadClassifier', () {
    test('classifies HTTPS URLs', () {
      expect(
        classifier.classify('https://example.com'),
        ScanContentType.httpsUrl,
      );
    });

    test('classifies HTTP URLs', () {
      expect(
        classifier.classify('http://example.com'),
        ScanContentType.httpUrl,
      );
    });

    test('classifies mailto links', () {
      expect(
        classifier.classify('mailto:user@example.com'),
        ScanContentType.mailto,
      );
    });

    test('classifies tel links', () {
      expect(
        classifier.classify('tel:+1234567890'),
        ScanContentType.tel,
      );
    });

    test('classifies SMS payloads', () {
      expect(
        classifier.classify('sms:+1234567890'),
        ScanContentType.sms,
      );
      expect(
        classifier.classify('SMSTO:+1234567890:Hello'),
        ScanContentType.sms,
      );
    });

    test('classifies Wi-Fi payloads', () {
      expect(
        classifier.classify('WIFI:T:WPA;S:MyNetwork;P:password;;'),
        ScanContentType.wifi,
      );
    });

    test('classifies vCard payloads', () {
      expect(
        classifier.classify('BEGIN:VCARD\nVERSION:3.0\nFN:John\nEND:VCARD'),
        ScanContentType.vCard,
      );
    });

    test('classifies MeCard payloads', () {
      expect(
        classifier.classify('MECARD:N:John,Doe;;'),
        ScanContentType.meCard,
      );
    });

    test('classifies calendar events', () {
      expect(
        classifier.classify('BEGIN:VEVENT\nSUMMARY:Meeting\nEND:VEVENT'),
        ScanContentType.calendarEvent,
      );
    });

    test('classifies geo coordinates', () {
      expect(
        classifier.classify('geo:37.7749,-122.4194'),
        ScanContentType.geoCoordinates,
      );
    });

    test('classifies email addresses', () {
      expect(
        classifier.classify('user@example.com'),
        ScanContentType.email,
      );
    });

    test('classifies phone numbers', () {
      expect(
        classifier.classify('+1234567890'),
        ScanContentType.phoneNumber,
      );
    });

    test('classifies deep links', () {
      expect(
        classifier.classify('myapp://path/to/resource'),
        ScanContentType.deepLink,
      );
    });

    test('classifies product barcodes', () {
      expect(
        classifier.classify('123456789012', barcodeFormat: BarcodeFormat.ean13),
        ScanContentType.productBarcode,
      );
    });

    test('classifies plain text', () {
      expect(
        classifier.classify('Hello, world!'),
        ScanContentType.plainText,
      );
    });

    test('classifies empty string as unknown', () {
      expect(
        classifier.classify(''),
        ScanContentType.unknown,
      );
    });

    test('classifies malformed content', () {
      // A string that starts with a known format prefix but is clearly incomplete
      expect(
        classifier.classify('BEGIN:VCARD'),
        ScanContentType.vCard,
      );
    });
  });
}
