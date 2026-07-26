import '../domain/scan_content_type.dart';
import '../domain/barcode_format.dart';

/// Classifies a raw scanned value into a [ScanContentType].
///
/// This is a pure, deterministic classifier that examines the
/// structure of the raw value to determine what type of content
/// it contains. It does not parse the payload — that is the job
/// of [PayloadParser].
class PayloadClassifier {
  /// Classifies a raw scanned value.
  ///
  /// [barcodeFormat] is used to distinguish product barcodes from
  /// QR-code-delivered content.
  ScanContentType classify(String rawValue, {BarcodeFormat barcodeFormat = BarcodeFormat.unknown}) {
    final value = rawValue.trim();

    if (value.isEmpty) {
      return ScanContentType.unknown;
    }

    // Product barcodes are identified by their barcode format.
    if (barcodeFormat.isProductBarcode) {
      return ScanContentType.productBarcode;
    }

    // Wi-Fi: WIFI:T:WPA;S:ssid;P:password;;
    if (value.startsWith('WIFI:') || value.startsWith('wifi:')) {
      return ScanContentType.wifi;
    }

    // mailto:
    if (value.startsWith('mailto:')) {
      return ScanContentType.mailto;
    }

    // tel:
    if (value.startsWith('tel:')) {
      return ScanContentType.tel;
    }

    // sms: or SMSTO:
    if (value.startsWith('sms:') ||
        value.startsWith('smsTo:') ||
        value.startsWith('SMSTO:') ||
        value.startsWith('smsto:')) {
      return ScanContentType.sms;
    }

    // vCard
    if (value.startsWith('BEGIN:VCARD')) {
      return ScanContentType.vCard;
    }

    // MeCard
    if (value.startsWith('MECARD:')) {
      return ScanContentType.meCard;
    }

    // Calendar event (VEVENT)
    if (value.startsWith('BEGIN:VEVENT')) {
      return ScanContentType.calendarEvent;
    }

    // geo: coordinates
    if (value.startsWith('geo:')) {
      return ScanContentType.geoCoordinates;
    }

    // HTTPS / HTTP URLs
    if (value.startsWith('https://')) {
      return ScanContentType.httpsUrl;
    }
    if (value.startsWith('http://')) {
      return ScanContentType.httpUrl;
    }

    // Deep links: scheme:// but not one of the known schemes above
    if (_hasCustomScheme(value)) {
      return ScanContentType.deepLink;
    }

    // Map links (Google Maps, Apple Maps, etc.)
    if (_isMapLink(value)) {
      return ScanContentType.mapLink;
    }

    // Email address (plain, without mailto:)
    if (_isEmailAddress(value)) {
      return ScanContentType.email;
    }

    // Phone number (plain digits, +, spaces, dashes)
    if (_isPhoneNumber(value)) {
      return ScanContentType.phoneNumber;
    }

    // GS1 data (starts with (01) or other AI prefixes)
    if (_isGs1Data(value)) {
      return ScanContentType.gs1Data;
    }

    // If nothing matched, it's plain text
    return ScanContentType.plainText;
  }

  bool _hasCustomScheme(String value) {
    final schemeMatch = RegExp(r'^([a-zA-Z][a-zA-Z0-9+.-]*):').firstMatch(value);
    if (schemeMatch == null) return false;
    final scheme = schemeMatch.group(1)!.toLowerCase();
    // Exclude known schemes already handled
    const knownSchemes = {
      'https', 'http', 'mailto', 'tel', 'sms', 'smsto', 'geo',
    };
    return !knownSchemes.contains(scheme);
  }

  bool _isMapLink(String value) {
    final lower = value.toLowerCase();
    return lower.contains('maps.google.com') ||
        lower.contains('maps.apple.com') ||
        lower.contains('openstreetmap.org') ||
        lower.contains('bing.com/maps');
  }

  bool _isEmailAddress(String value) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value);
  }

  bool _isPhoneNumber(String value) {
    // Strip common separators and check if it's mostly digits
    final stripped = value.replaceAll(RegExp(r'[\s\-\(\)\.]'), '');
    if (stripped.isEmpty) return false;
    if (!stripped.startsWith('+') && !RegExp(r'^\d+$').hasMatch(stripped)) {
      return false;
    }
    final digitsOnly = stripped.replaceAll(RegExp(r'[^\d]'), '');
    return digitsOnly.length >= 7 && digitsOnly.length <= 15;
  }

  bool _isGs1Data(String value) {
    // GS1 data barcodes often start with AI (01), (10), (17), etc.
    return RegExp(r'^\(\d{2,4}\)').hasMatch(value) ||
        // FNC1 prefix in QR codes
        value.startsWith(']Q3') ||
        value.startsWith(']d2');
  }
}
