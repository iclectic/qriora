import 'package:freezed_annotation/freezed_annotation.dart';

import 'scan_content_type.dart';
import 'barcode_format.dart';
import '../../analysis/domain/extracted_entity.dart';

part 'scan_payload.freezed.dart';
part 'scan_payload.g.dart';

/// Represents the parsed payload of a scanned code.
///
/// Contains the raw value, normalised value, classified content type,
/// and any structured entities extracted from the payload.
@freezed
class ScanPayload with _$ScanPayload {
  const factory ScanPayload({
    /// The raw value as returned by the scanner.
    required String rawValue,

    /// The normalised value (e.g. trimmed, lowercased domain).
    required String normalisedValue,

    /// The classified content type.
    required ScanContentType contentType,

    /// The barcode format detected by the scanner.
    @Default(BarcodeFormat.unknown) BarcodeFormat barcodeFormat,

    /// Structured entities extracted from the payload.
    @Default(<ExtractedEntity>[]) List<ExtractedEntity> entities,

    /// Whether the payload contains sensitive data (e.g. Wi-Fi password).
    @Default(false) bool isSensitive,
  }) = _ScanPayload;

  factory ScanPayload.fromJson(Map<String, dynamic> json) =>
      _$ScanPayloadFromJson(json);
}
