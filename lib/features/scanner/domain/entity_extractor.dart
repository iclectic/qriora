import 'scan_payload.dart';
import 'scan_content_type.dart';
import '../../analysis/domain/extracted_entity.dart';

/// Extracts additional entities from a parsed payload that may not
/// have been captured during initial parsing.
///
/// For example, a URL payload may contain an email address or phone
/// number embedded in query parameters.
class EntityExtractor {
  /// Extracts additional entities from a [ScanPayload].
  List<ExtractedEntity> extract(ScanPayload payload) {
    final entities = <ExtractedEntity>[...payload.entities];

    // For URL types, try to extract embedded entities
    if (payload.contentType == ScanContentType.httpsUrl ||
        payload.contentType == ScanContentType.httpUrl ||
        payload.contentType == ScanContentType.mapLink) {
      entities.addAll(_extractFromUrl(payload.normalisedValue));
    }

    // For plain text, try to find emails, phone numbers, URLs
    if (payload.contentType == ScanContentType.plainText) {
      entities.addAll(_extractFromText(payload.normalisedValue));
    }

    // Deduplicate by type+value
    final seen = <String>{};
    return entities.where((e) {
      final key = '${e.type}:${e.value}';
      if (seen.contains(key)) return false;
      seen.add(key);
      return true;
    }).toList();
  }

  List<ExtractedEntity> _extractFromUrl(String url) {
    final entities = <ExtractedEntity>[];
    try {
      final uri = Uri.parse(url);
      // Check for email in path
      final emailMatch = RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}')
          .firstMatch(uri.path);
      if (emailMatch != null) {
        entities.add(ExtractedEntity(
          type: ExtractedEntityType.emailAddress,
          value: emailMatch.group(0)!,
        ));
      }
    } catch (_) {
      // ignore
    }
    return entities;
  }

  List<ExtractedEntity> _extractFromText(String text) {
    final entities = <ExtractedEntity>[];

    // Extract URLs
    final urlMatches = RegExp(r'https?://[^\s]+').allMatches(text);
    for (final match in urlMatches) {
      entities.add(ExtractedEntity(type: ExtractedEntityType.url, value: match.group(0)!));
    }

    // Extract email addresses
    final emailMatches = RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}')
        .allMatches(text);
    for (final match in emailMatches) {
      entities.add(ExtractedEntity(
        type: ExtractedEntityType.emailAddress,
        value: match.group(0)!,
      ));
    }

    // Extract phone numbers (simple heuristic)
    final phoneMatches = RegExp(r'\+?\d[\d\s\-\(\)\.]{6,}\d').allMatches(text);
    for (final match in phoneMatches) {
      final phone = match.group(0)!.trim();
      final digits = phone.replaceAll(RegExp(r'[^\d]'), '');
      if (digits.length >= 7 && digits.length <= 15) {
        entities.add(ExtractedEntity(type: ExtractedEntityType.phoneNumber, value: phone));
      }
    }

    return entities;
  }
}
