import 'package:freezed_annotation/freezed_annotation.dart';

import 'scan_payload.dart';
import 'scan_source.dart';
import '../../analysis/domain/analysis_result.dart';

part 'scan_record.freezed.dart';
part 'scan_record.g.dart';

/// A complete scan record including payload, analysis, and metadata.
@freezed
class ScanRecord with _$ScanRecord {
  const factory ScanRecord({
    /// Unique identifier.
    required String id,

    /// The parsed payload.
    required ScanPayload payload,

    /// The source of the scan.
    required ScanSource source,

    /// When the scan was performed.
    required DateTime scannedAt,

    /// The analysis result.
    required AnalysisResult analysis,

    /// Whether this scan is marked as a favourite.
    @Default(false) bool isFavourite,

    /// Optional user note.
    String? note,

    /// Whether the scan contains sensitive content.
    @Default(false) bool isSensitive,

    /// Version of the analysis engine used.
    required String analysisVersion,
  }) = _ScanRecord;

  factory ScanRecord.fromJson(Map<String, dynamic> json) =>
      _$ScanRecordFromJson(json);
}
