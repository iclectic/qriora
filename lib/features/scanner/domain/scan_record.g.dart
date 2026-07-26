// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScanRecordImpl _$$ScanRecordImplFromJson(Map<String, dynamic> json) =>
    _$ScanRecordImpl(
      id: json['id'] as String,
      payload: ScanPayload.fromJson(json['payload'] as Map<String, dynamic>),
      source: $enumDecode(_$ScanSourceEnumMap, json['source']),
      scannedAt: DateTime.parse(json['scannedAt'] as String),
      analysis: AnalysisResult.fromJson(
        json['analysis'] as Map<String, dynamic>,
      ),
      isFavourite: json['isFavourite'] as bool? ?? false,
      note: json['note'] as String?,
      isSensitive: json['isSensitive'] as bool? ?? false,
      analysisVersion: json['analysisVersion'] as String,
    );

Map<String, dynamic> _$$ScanRecordImplToJson(_$ScanRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'payload': instance.payload,
      'source': _$ScanSourceEnumMap[instance.source]!,
      'scannedAt': instance.scannedAt.toIso8601String(),
      'analysis': instance.analysis,
      'isFavourite': instance.isFavourite,
      'note': instance.note,
      'isSensitive': instance.isSensitive,
      'analysisVersion': instance.analysisVersion,
    };

const _$ScanSourceEnumMap = {
  ScanSource.camera: 'camera',
  ScanSource.imageFile: 'imageFile',
  ScanSource.manualEntry: 'manualEntry',
  ScanSource.imported: 'imported',
};
