import 'package:flutter_test/flutter_test.dart';
import 'package:qriora/features/scanner/domain/entity_extractor.dart';
import 'package:qriora/features/scanner/domain/scan_payload.dart';
import 'package:qriora/features/scanner/domain/scan_content_type.dart';
import 'package:qriora/features/scanner/domain/barcode_format.dart';
import 'package:qriora/features/analysis/domain/extracted_entity.dart';

void main() {
  late EntityExtractor extractor;

  setUp(() {
    extractor = EntityExtractor();
  });

  ScanPayload buildPayload(
    String value, {
    ScanContentType contentType = ScanContentType.plainText,
    List<ExtractedEntity> entities = const [],
  }) {
    return ScanPayload(
      rawValue: value,
      normalisedValue: value,
      contentType: contentType,
      barcodeFormat: BarcodeFormat.unknown,
      entities: entities,
    );
  }

  group('EntityExtractor', () {
    test('extracts email from text', () {
      final payload = buildPayload('Contact me at user@example.com');
      final entities = extractor.extract(payload);
      expect(entities.any((e) => e.type == ExtractedEntityType.emailAddress), isTrue);
    });

    test('extracts URL from text', () {
      final payload = buildPayload('Visit https://example.com today');
      final entities = extractor.extract(payload);
      expect(entities.any((e) => e.type == ExtractedEntityType.url), isTrue);
    });

    test('returns empty for empty text', () {
      final payload = buildPayload('');
      final entities = extractor.extract(payload);
      expect(entities, isEmpty);
    });

    test('deduplicates entities', () {
      final payload = buildPayload('user@example.com user@example.com');
      final entities = extractor.extract(payload);
      final emailCount = entities.where((e) => e.type == ExtractedEntityType.emailAddress).length;
      expect(emailCount, 1);
    });
  });
}
