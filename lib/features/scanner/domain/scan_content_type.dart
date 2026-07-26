import 'package:flutter/material.dart';

/// Represents the type of content detected in a scanned code.
///
/// Each type corresponds to a structured parsing strategy.
/// [ScanContentType.unknown] is used when the payload cannot be
/// confidently classified, and [ScanContentType.malformed] is used
/// when the payload resembles a known format but fails to parse.
enum ScanContentType {
  httpsUrl,
  httpUrl,
  email,
  mailto,
  phoneNumber,
  tel,
  sms,
  wifi,
  vCard,
  meCard,
  calendarEvent,
  geoCoordinates,
  mapLink,
  deepLink,
  productBarcode,
  gs1Data,
  plainText,
  unknown,
  malformed;

  /// A human-readable label for display in the UI.
  String get label {
    switch (this) {
      case ScanContentType.httpsUrl:
        return 'HTTPS URL';
      case ScanContentType.httpUrl:
        return 'HTTP URL';
      case ScanContentType.email:
        return 'Email address';
      case ScanContentType.mailto:
        return 'Mailto link';
      case ScanContentType.phoneNumber:
        return 'Phone number';
      case ScanContentType.tel:
        return 'Tel link';
      case ScanContentType.sms:
        return 'SMS payload';
      case ScanContentType.wifi:
        return 'Wi-Fi credentials';
      case ScanContentType.vCard:
        return 'vCard contact';
      case ScanContentType.meCard:
        return 'MeCard contact';
      case ScanContentType.calendarEvent:
        return 'Calendar event';
      case ScanContentType.geoCoordinates:
        return 'Geographic coordinates';
      case ScanContentType.mapLink:
        return 'Map link';
      case ScanContentType.deepLink:
        return 'App deep link';
      case ScanContentType.productBarcode:
        return 'Product barcode';
      case ScanContentType.gs1Data:
        return 'GS1 data';
      case ScanContentType.plainText:
        return 'Plain text';
      case ScanContentType.unknown:
        return 'Unknown content';
      case ScanContentType.malformed:
        return 'Malformed content';
    }
  }

  /// A short description of what this content type represents.
  String get description {
    switch (this) {
      case ScanContentType.httpsUrl:
        return 'A web link using a secure HTTPS connection.';
      case ScanContentType.httpUrl:
        return 'A web link using an unencrypted HTTP connection.';
      case ScanContentType.email:
        return 'An email address.';
      case ScanContentType.mailto:
        return 'A link that opens an email composer with pre-filled fields.';
      case ScanContentType.phoneNumber:
        return 'A phone number.';
      case ScanContentType.tel:
        return 'A link that initiates a phone call.';
      case ScanContentType.sms:
        return 'A link that opens a messaging app with pre-filled text.';
      case ScanContentType.wifi:
        return 'Wi-Fi network credentials that can join a network.';
      case ScanContentType.vCard:
        return 'A contact card that can be saved to your address book.';
      case ScanContentType.meCard:
        return 'A simplified contact card that can be saved to your address book.';
      case ScanContentType.calendarEvent:
        return 'A calendar event that can be added to your calendar.';
      case ScanContentType.geoCoordinates:
        return 'Geographic coordinates that can be opened in a map app.';
      case ScanContentType.mapLink:
        return 'A link that opens a location in a map application.';
      case ScanContentType.deepLink:
        return 'A link that may open a specific application on your device.';
      case ScanContentType.productBarcode:
        return 'A product barcode (e.g. EAN, UPC) identifying a retail item.';
      case ScanContentType.gs1Data:
        return 'Structured GS1 supply-chain data.';
      case ScanContentType.plainText:
        return 'Plain text with no special action associated.';
      case ScanContentType.unknown:
        return 'The content could not be identified.';
      case ScanContentType.malformed:
        return 'The content resembles a known format but could not be fully parsed.';
    }
  }

  /// An icon representing this content type for non-colour-based communication.
  IconData get icon {
    switch (this) {
      case ScanContentType.httpsUrl:
      case ScanContentType.httpUrl:
        return Icons.link;
      case ScanContentType.email:
      case ScanContentType.mailto:
        return Icons.email_outlined;
      case ScanContentType.phoneNumber:
      case ScanContentType.tel:
        return Icons.phone_outlined;
      case ScanContentType.sms:
        return Icons.sms_outlined;
      case ScanContentType.wifi:
        return Icons.wifi;
      case ScanContentType.vCard:
      case ScanContentType.meCard:
        return Icons.contact_page_outlined;
      case ScanContentType.calendarEvent:
        return Icons.event_outlined;
      case ScanContentType.geoCoordinates:
      case ScanContentType.mapLink:
        return Icons.map_outlined;
      case ScanContentType.deepLink:
        return Icons.apps;
      case ScanContentType.productBarcode:
      case ScanContentType.gs1Data:
        return Icons.qr_code_2;
      case ScanContentType.plainText:
        return Icons.text_snippet_outlined;
      case ScanContentType.unknown:
        return Icons.help_outline;
      case ScanContentType.malformed:
        return Icons.error_outline;
    }
  }

  /// Whether this content type is considered sensitive and should be
  /// masked by default in the UI.
  bool get isSensitive {
    switch (this) {
      case ScanContentType.wifi:
        return true;
      default:
        return false;
    }
  }
}
