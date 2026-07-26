// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risk_finding.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RiskFindingImpl _$$RiskFindingImplFromJson(Map<String, dynamic> json) =>
    _$RiskFindingImpl(
      ruleId: json['ruleId'] as String,
      severity: $enumDecode(_$RiskSeverityEnumMap, json['severity']),
      title: json['title'] as String,
      explanation: json['explanation'] as String,
      evidence: json['evidence'] as String,
      recommendedResponse: json['recommendedResponse'] as String,
      analysisMethod: $enumDecode(
        _$AnalysisMethodEnumMap,
        json['analysisMethod'],
      ),
      ruleVersion: json['ruleVersion'] as String,
    );

Map<String, dynamic> _$$RiskFindingImplToJson(_$RiskFindingImpl instance) =>
    <String, dynamic>{
      'ruleId': instance.ruleId,
      'severity': _$RiskSeverityEnumMap[instance.severity]!,
      'title': instance.title,
      'explanation': instance.explanation,
      'evidence': instance.evidence,
      'recommendedResponse': instance.recommendedResponse,
      'analysisMethod': _$AnalysisMethodEnumMap[instance.analysisMethod]!,
      'ruleVersion': instance.ruleVersion,
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
