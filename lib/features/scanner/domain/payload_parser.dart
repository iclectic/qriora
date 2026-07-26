import 'scan_content_type.dart';
import 'scan_payload.dart';
import 'barcode_format.dart';
import '../../analysis/domain/extracted_entity.dart';

/// Parses a raw scanned value into a structured [ScanPayload].
///
/// Each content type has a dedicated parsing method. Parsing is
/// kept entirely outside of UI widgets so it can be tested
/// independently.
class PayloadParser {
  /// Parses a raw scanned value into a [ScanPayload].
  ///
  /// [contentType] should be determined beforehand by [PayloadClassifier].
  /// [barcodeFormat] is passed through from the scanner.
  ScanPayload parse(
    String rawValue, {
    required ScanContentType contentType,
    BarcodeFormat barcodeFormat = BarcodeFormat.unknown,
  }) {
    final normalised = _normalise(rawValue);

    switch (contentType) {
      case ScanContentType.httpsUrl:
      case ScanContentType.httpUrl:
        return _parseUrl(rawValue, normalised, contentType, barcodeFormat);
      case ScanContentType.email:
        return _parseEmail(rawValue, normalised, contentType, barcodeFormat);
      case ScanContentType.mailto:
        return _parseMailto(rawValue, normalised, contentType, barcodeFormat);
      case ScanContentType.phoneNumber:
        return _parsePhone(rawValue, normalised, contentType, barcodeFormat);
      case ScanContentType.tel:
        return _parseTel(rawValue, normalised, contentType, barcodeFormat);
      case ScanContentType.sms:
        return _parseSms(rawValue, normalised, contentType, barcodeFormat);
      case ScanContentType.wifi:
        return _parseWifi(rawValue, normalised, contentType, barcodeFormat);
      case ScanContentType.vCard:
        return _parseVCard(rawValue, normalised, contentType, barcodeFormat);
      case ScanContentType.meCard:
        return _parseMeCard(rawValue, normalised, contentType, barcodeFormat);
      case ScanContentType.calendarEvent:
        return _parseCalendarEvent(rawValue, normalised, contentType, barcodeFormat);
      case ScanContentType.geoCoordinates:
        return _parseGeo(rawValue, normalised, contentType, barcodeFormat);
      case ScanContentType.mapLink:
        return _parseMapLink(rawValue, normalised, contentType, barcodeFormat);
      case ScanContentType.deepLink:
        return _parseDeepLink(rawValue, normalised, contentType, barcodeFormat);
      case ScanContentType.productBarcode:
        return _parseProductBarcode(rawValue, normalised, contentType, barcodeFormat);
      case ScanContentType.gs1Data:
        return _parseGs1(rawValue, normalised, contentType, barcodeFormat);
      case ScanContentType.plainText:
        return ScanPayload(
          rawValue: rawValue,
          normalisedValue: normalised,
          contentType: contentType,
          barcodeFormat: barcodeFormat,
          entities: [
            ExtractedEntity(type: ExtractedEntityType.text, value: normalised),
          ],
        );
      case ScanContentType.unknown:
        return ScanPayload(
          rawValue: rawValue,
          normalisedValue: normalised,
          contentType: contentType,
          barcodeFormat: barcodeFormat,
        );
      case ScanContentType.malformed:
        return ScanPayload(
          rawValue: rawValue,
          normalisedValue: normalised,
          contentType: contentType,
          barcodeFormat: barcodeFormat,
        );
    }
  }

  String _normalise(String value) {
    return value.trim().replaceAll('\r\n', '\n').replaceAll('\r', '\n');
  }

  ScanPayload _parseUrl(
    String raw,
    String normalised,
    ScanContentType type,
    BarcodeFormat format,
  ) {
    final entities = <ExtractedEntity>[];
    entities.add(ExtractedEntity(type: ExtractedEntityType.url, value: normalised));

    // Extract domain
    try {
      final uri = Uri.parse(normalised);
      if (uri.host.isNotEmpty) {
        entities.add(ExtractedEntity(type: ExtractedEntityType.domain, value: uri.host));
      }
    } catch (_) {
      // If URL parsing fails, we still have the raw value
    }

    return ScanPayload(
      rawValue: raw,
      normalisedValue: normalised,
      contentType: type,
      barcodeFormat: format,
      entities: entities,
    );
  }

  ScanPayload _parseEmail(
    String raw,
    String normalised,
    ScanContentType type,
    BarcodeFormat format,
  ) {
    return ScanPayload(
      rawValue: raw,
      normalisedValue: normalised,
      contentType: type,
      barcodeFormat: format,
      entities: [
        ExtractedEntity(type: ExtractedEntityType.emailAddress, value: normalised),
      ],
    );
  }

  ScanPayload _parseMailto(
    String raw,
    String normalised,
    ScanContentType type,
    BarcodeFormat format,
  ) {
    final entities = <ExtractedEntity>[];
    try {
      final uri = Uri.parse(normalised);
      final email = uri.path;
      if (email.isNotEmpty) {
        entities.add(ExtractedEntity(type: ExtractedEntityType.emailAddress, value: email));
      }
      final subject = uri.queryParameters['subject'];
      if (subject != null) {
        entities.add(ExtractedEntity(type: ExtractedEntityType.subject, value: subject));
      }
      final body = uri.queryParameters['body'];
      if (body != null) {
        entities.add(ExtractedEntity(type: ExtractedEntityType.body, value: body));
      }
    } catch (_) {
      // Fallback: extract email after mailto:
      final email = normalised.substring(7).split('?').first;
      entities.add(ExtractedEntity(type: ExtractedEntityType.emailAddress, value: email));
    }

    return ScanPayload(
      rawValue: raw,
      normalisedValue: normalised,
      contentType: type,
      barcodeFormat: format,
      entities: entities,
    );
  }

  ScanPayload _parsePhone(
    String raw,
    String normalised,
    ScanContentType type,
    BarcodeFormat format,
  ) {
    return ScanPayload(
      rawValue: raw,
      normalisedValue: normalised,
      contentType: type,
      barcodeFormat: format,
      entities: [
        ExtractedEntity(type: ExtractedEntityType.phoneNumber, value: normalised),
      ],
    );
  }

  ScanPayload _parseTel(
    String raw,
    String normalised,
    ScanContentType type,
    BarcodeFormat format,
  ) {
    final phone = normalised.substring(4); // Remove 'tel:'
    return ScanPayload(
      rawValue: raw,
      normalisedValue: normalised,
      contentType: type,
      barcodeFormat: format,
      entities: [
        ExtractedEntity(type: ExtractedEntityType.phoneNumber, value: phone),
      ],
    );
  }

  ScanPayload _parseSms(
    String raw,
    String normalised,
    ScanContentType type,
    BarcodeFormat format,
  ) {
    final entities = <ExtractedEntity>[];
    // Handle sms: and SMSTO: formats
    String phone;
    String? body;

    if (normalised.startsWith('SMSTO:') || normalised.startsWith('smsto:')) {
      // SMSTO:number:message
      final rest = normalised.substring(6);
      final parts = rest.split(':');
      phone = parts.first;
      if (parts.length > 1) {
        body = parts.sublist(1).join(':');
      }
    } else {
      // sms:number?body=...
      final rest = normalised.substring(4);
      try {
        final uri = Uri.parse(rest);
        phone = uri.path;
        body = uri.queryParameters['body'];
      } catch (_) {
        phone = rest.split('?').first;
      }
    }

    entities.add(ExtractedEntity(type: ExtractedEntityType.phoneNumber, value: phone));
    if (body != null && body.isNotEmpty) {
      entities.add(ExtractedEntity(type: ExtractedEntityType.body, value: body));
    }

    return ScanPayload(
      rawValue: raw,
      normalisedValue: normalised,
      contentType: type,
      barcodeFormat: format,
      entities: entities,
    );
  }

  ScanPayload _parseWifi(
    String raw,
    String normalised,
    ScanContentType type,
    BarcodeFormat format,
  ) {
    final entities = <ExtractedEntity>[];
    // WIFI:T:WPA;S:ssid;P:password;H:true;;
    final content = normalised.substring(5); // Remove 'WIFI:'
    final parts = content.split(';');

    String? ssid, password, encryption;
    for (final part in parts) {
      final eqIdx = part.indexOf(':');
      if (eqIdx == -1) continue;
      final key = part.substring(0, eqIdx).toUpperCase();
      final value = part.substring(eqIdx + 1);
      switch (key) {
        case 'S':
          ssid = value;
          break;
        case 'P':
          password = value;
          break;
        case 'T':
          encryption = value;
          break;
      }
    }

    if (ssid != null) {
      entities.add(ExtractedEntity(type: ExtractedEntityType.ssid, value: ssid));
    }
    if (password != null) {
      entities.add(
        ExtractedEntity(
          type: ExtractedEntityType.password,
          value: password,
          isSensitive: true,
        ),
      );
    }
    if (encryption != null) {
      entities.add(ExtractedEntity(type: ExtractedEntityType.encryptionType, value: encryption));
    }

    return ScanPayload(
      rawValue: raw,
      normalisedValue: normalised,
      contentType: type,
      barcodeFormat: format,
      entities: entities,
      isSensitive: true,
    );
  }

  ScanPayload _parseVCard(
    String raw,
    String normalised,
    ScanContentType type,
    BarcodeFormat format,
  ) {
    final entities = <ExtractedEntity>[];
    final lines = normalised.split('\n');

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.startsWith('FN:')) {
        entities.add(ExtractedEntity(
          type: ExtractedEntityType.contactName,
          value: trimmed.substring(3),
        ));
      } else if (trimmed.startsWith('N:')) {
        final name = trimmed.substring(2);
        // N:Last;First;Middle;Prefix;Suffix
        final nameParts = name.split(';');
        final fullName = nameParts.where((p) => p.isNotEmpty).join(' ');
        if (fullName.isNotEmpty && !entities.any((e) => e.type == ExtractedEntityType.contactName)) {
          entities.add(ExtractedEntity(
            type: ExtractedEntityType.contactName,
            value: fullName,
          ));
        }
      } else if (trimmed.startsWith('ORG:')) {
        entities.add(ExtractedEntity(
          type: ExtractedEntityType.organisation,
          value: trimmed.substring(4),
        ));
      } else if (trimmed.startsWith('TEL')) {
        final colonIdx = trimmed.indexOf(':');
        if (colonIdx != -1) {
          entities.add(ExtractedEntity(
            type: ExtractedEntityType.phone,
            value: trimmed.substring(colonIdx + 1),
          ));
        }
      } else if (trimmed.startsWith('EMAIL')) {
        final colonIdx = trimmed.indexOf(':');
        if (colonIdx != -1) {
          entities.add(ExtractedEntity(
            type: ExtractedEntityType.email,
            value: trimmed.substring(colonIdx + 1),
          ));
        }
      } else if (trimmed.startsWith('ADR')) {
        final colonIdx = trimmed.indexOf(':');
        if (colonIdx != -1) {
          entities.add(ExtractedEntity(
            type: ExtractedEntityType.address,
            value: trimmed.substring(colonIdx + 1),
          ));
        }
      }
    }

    return ScanPayload(
      rawValue: raw,
      normalisedValue: normalised,
      contentType: type,
      barcodeFormat: format,
      entities: entities,
    );
  }

  ScanPayload _parseMeCard(
    String raw,
    String normalised,
    ScanContentType type,
    BarcodeFormat format,
  ) {
    final entities = <ExtractedEntity>[];
    // MECARD:N:Last,First;TEL:123456;EMAIL:a@b.com;;
    final content = normalised.substring(7); // Remove 'MECARD:'
    final fields = content.split(';');

    for (final field in fields) {
      if (field.isEmpty) continue;
      final colonIdx = field.indexOf(':');
      if (colonIdx == -1) continue;
      final key = field.substring(0, colonIdx).toUpperCase();
      final value = field.substring(colonIdx + 1);

      switch (key) {
        case 'N':
          // N:Last,First
          final nameParts = value.split(',');
          final fullName = nameParts.reversed.join(' ').trim();
          entities.add(ExtractedEntity(
            type: ExtractedEntityType.contactName,
            value: fullName.isNotEmpty ? fullName : value,
          ));
          break;
        case 'TEL':
          entities.add(ExtractedEntity(type: ExtractedEntityType.phone, value: value));
          break;
        case 'EMAIL':
          entities.add(ExtractedEntity(type: ExtractedEntityType.email, value: value));
          break;
        case 'ADR':
          entities.add(ExtractedEntity(type: ExtractedEntityType.address, value: value));
          break;
        case 'ORG':
          entities.add(ExtractedEntity(type: ExtractedEntityType.organisation, value: value));
          break;
      }
    }

    return ScanPayload(
      rawValue: raw,
      normalisedValue: normalised,
      contentType: type,
      barcodeFormat: format,
      entities: entities,
    );
  }

  ScanPayload _parseCalendarEvent(
    String raw,
    String normalised,
    ScanContentType type,
    BarcodeFormat format,
  ) {
    final entities = <ExtractedEntity>[];
    final lines = normalised.split('\n');

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.startsWith('SUMMARY:')) {
        entities.add(ExtractedEntity(
          type: ExtractedEntityType.eventTitle,
          value: trimmed.substring(8),
        ));
      } else if (trimmed.startsWith('DTSTART')) {
        final colonIdx = trimmed.indexOf(':');
        if (colonIdx != -1) {
          entities.add(ExtractedEntity(
            type: ExtractedEntityType.eventStart,
            value: trimmed.substring(colonIdx + 1),
          ));
        }
      } else if (trimmed.startsWith('DTEND')) {
        final colonIdx = trimmed.indexOf(':');
        if (colonIdx != -1) {
          entities.add(ExtractedEntity(
            type: ExtractedEntityType.eventEnd,
            value: trimmed.substring(colonIdx + 1),
          ));
        }
      } else if (trimmed.startsWith('LOCATION:')) {
        entities.add(ExtractedEntity(
          type: ExtractedEntityType.eventLocation,
          value: trimmed.substring(9),
        ));
      }
    }

    return ScanPayload(
      rawValue: raw,
      normalisedValue: normalised,
      contentType: type,
      barcodeFormat: format,
      entities: entities,
    );
  }

  ScanPayload _parseGeo(
    String raw,
    String normalised,
    ScanContentType type,
    BarcodeFormat format,
  ) {
    final entities = <ExtractedEntity>[];
    // geo:lat,lng
    final content = normalised.substring(4); // Remove 'geo:'
    final parts = content.split(',');
    if (parts.length >= 2) {
      entities.add(ExtractedEntity(type: ExtractedEntityType.latitude, value: parts[0]));
      entities.add(ExtractedEntity(type: ExtractedEntityType.longitude, value: parts[1]));
    }

    return ScanPayload(
      rawValue: raw,
      normalisedValue: normalised,
      contentType: type,
      barcodeFormat: format,
      entities: entities,
    );
  }

  ScanPayload _parseMapLink(
    String raw,
    String normalised,
    ScanContentType type,
    BarcodeFormat format,
  ) {
    final entities = <ExtractedEntity>[];
    entities.add(ExtractedEntity(type: ExtractedEntityType.url, value: normalised));

    // Try to extract coordinates from query params
    try {
      final uri = Uri.parse(normalised);
      final q = uri.queryParameters['q'] ?? uri.queryParameters['query'] ?? '';
      if (q.isNotEmpty) {
        final coordParts = q.split(',');
        if (coordParts.length == 2) {
          final lat = double.tryParse(coordParts[0]);
          final lng = double.tryParse(coordParts[1]);
          if (lat != null && lng != null) {
            entities.add(ExtractedEntity(type: ExtractedEntityType.latitude, value: coordParts[0]));
            entities.add(ExtractedEntity(type: ExtractedEntityType.longitude, value: coordParts[1]));
          }
        }
      }
    } catch (_) {
      // ignore
    }

    return ScanPayload(
      rawValue: raw,
      normalisedValue: normalised,
      contentType: type,
      barcodeFormat: format,
      entities: entities,
    );
  }

  ScanPayload _parseDeepLink(
    String raw,
    String normalised,
    ScanContentType type,
    BarcodeFormat format,
  ) {
    return ScanPayload(
      rawValue: raw,
      normalisedValue: normalised,
      contentType: type,
      barcodeFormat: format,
      entities: [
        ExtractedEntity(type: ExtractedEntityType.url, value: normalised),
      ],
    );
  }

  ScanPayload _parseProductBarcode(
    String raw,
    String normalised,
    ScanContentType type,
    BarcodeFormat format,
  ) {
    return ScanPayload(
      rawValue: raw,
      normalisedValue: normalised,
      contentType: type,
      barcodeFormat: format,
      entities: [
        ExtractedEntity(type: ExtractedEntityType.productId, value: normalised),
      ],
    );
  }

  ScanPayload _parseGs1(
    String raw,
    String normalised,
    ScanContentType type,
    BarcodeFormat format,
  ) {
    final entities = <ExtractedEntity>[];
    // Extract AI (01) -> GTIN
    final aiMatches = RegExp(r'\((\d{2,4})\)([^\(]*)').allMatches(normalised);
    for (final match in aiMatches) {
      final ai = match.group(1)!;
      final value = match.group(2)!;
      // AI 01 = GTIN
      if (ai == '01') {
        entities.add(ExtractedEntity(type: ExtractedEntityType.productId, value: value));
      } else {
        entities.add(ExtractedEntity(type: ExtractedEntityType.text, value: '($ai) $value'));
      }
    }

    return ScanPayload(
      rawValue: raw,
      normalisedValue: normalised,
      contentType: type,
      barcodeFormat: format,
      entities: entities,
    );
  }
}
