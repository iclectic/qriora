// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnalysisResultImpl _$$AnalysisResultImplFromJson(
  Map<String, dynamic> json,
) => _$AnalysisResultImpl(
  overallSeverity: $enumDecode(_$RiskSeverityEnumMap, json['overallSeverity']),
  findings:
      (json['findings'] as List<dynamic>?)
          ?.map((e) => RiskFinding.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <RiskFinding>[],
  summary: json['summary'] as String,
  limitations:
      (json['limitations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  analysisVersion: json['analysisVersion'] as String,
  analysisMethod: $enumDecode(_$AnalysisMethodEnumMap, json['analysisMethod']),
  usedNetworkLookup: json['usedNetworkLookup'] as bool? ?? false,
);

Map<String, dynamic> _$$AnalysisResultImplToJson(
  _$AnalysisResultImpl instance,
) => <String, dynamic>{
  'overallSeverity': _$RiskSeverityEnumMap[instance.overallSeverity]!,
  'findings': instance.findings,
  'summary': instance.summary,
  'limitations': instance.limitations,
  'analysisVersion': instance.analysisVersion,
  'analysisMethod': _$AnalysisMethodEnumMap[instance.analysisMethod]!,
  'usedNetworkLookup': instance.usedNetworkLookup,
};

const _$RiskSeverityEnumMap = {
  RiskSeverity.informational: 'informational',
  RiskSeverity.caution: 'caution',
  RiskSeverity.highRisk: 'highRisk',
  RiskSeverity.unableToDetermine: 'unableToDetermine',
};

const _$AnalysisMethodEnumMap = {
  AnalysisMethod.deterministicRule: 'deterministicRule',
  AnalysisMethod.aiSupplemented: 'aiSupplemented',
  AnalysisMethod.heuristic: 'heuristic',
};
