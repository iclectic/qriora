import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'risk_severity.dart';
import 'analysis_method.dart';

part 'risk_finding.freezed.dart';
part 'risk_finding.g.dart';

/// A single risk finding produced by the analysis engine.
///
/// Each finding includes a stable rule identifier, severity,
/// plain-language explanation, evidence, and a recommended response.
@freezed
class RiskFinding with _$RiskFinding {
  const factory RiskFinding({
    /// Stable identifier for the rule that produced this finding.
    /// Used for deduplication and for referencing in tests.
    required String ruleId,

    /// Severity level of this finding.
    required RiskSeverity severity,

    /// Short, human-readable title.
    required String title,

    /// Plain-language explanation of why this finding was shown.
    required String explanation,

    /// The specific evidence from the payload that caused this finding.
    required String evidence,

    /// What the user should do in response.
    required String recommendedResponse,

    /// Whether this finding was produced by deterministic rules,
    /// heuristics, or AI supplementation.
    required AnalysisMethod analysisMethod,

    /// Version of the rule or engine that produced this finding.
    required String ruleVersion,
  }) = _RiskFinding;

  factory RiskFinding.fromJson(Map<String, dynamic> json) =>
      _$RiskFindingFromJson(json);
}

/// Icon for a risk severity level, for colour-independent communication.
IconData riskSeverityIcon(RiskSeverity severity) {
  switch (severity) {
    case RiskSeverity.informational:
      return Icons.info_outline;
    case RiskSeverity.caution:
      return Icons.warning_amber_outlined;
    case RiskSeverity.highRisk:
      return Icons.dangerous_outlined;
    case RiskSeverity.unableToDetermine:
      return Icons.help_outline;
  }
}
