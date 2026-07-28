// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnalysisReportImpl _$$AnalysisReportImplFromJson(Map<String, dynamic> json) =>
    _$AnalysisReportImpl(
      id: json['id'] as String,
      scanId: json['scanId'] as String,
      ruleId: json['ruleId'] as String,
      findingIndex: (json['findingIndex'] as num).toInt(),
      category: $enumDecode(_$AnalysisReportCategoryEnumMap, json['category']),
      comment: json['comment'] as String?,
      submittedAt: DateTime.parse(json['submittedAt'] as String),
      analysisVersion: json['analysisVersion'] as String,
    );

Map<String, dynamic> _$$AnalysisReportImplToJson(
  _$AnalysisReportImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'scanId': instance.scanId,
  'ruleId': instance.ruleId,
  'findingIndex': instance.findingIndex,
  'category': _$AnalysisReportCategoryEnumMap[instance.category]!,
  'comment': instance.comment,
  'submittedAt': instance.submittedAt.toIso8601String(),
  'analysisVersion': instance.analysisVersion,
};

const _$AnalysisReportCategoryEnumMap = {
  AnalysisReportCategory.falsePositive: 'falsePositive',
  AnalysisReportCategory.missingRisk: 'missingRisk',
  AnalysisReportCategory.incorrectSeverity: 'incorrectSeverity',
  AnalysisReportCategory.unclearExplanation: 'unclearExplanation',
  AnalysisReportCategory.other: 'other',
};
