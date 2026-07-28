import 'package:freezed_annotation/freezed_annotation.dart';

part 'analysis_report.freezed.dart';
part 'analysis_report.g.dart';

/// Represents a user-submitted report about an incorrect analysis finding.
@freezed
class AnalysisReport with _$AnalysisReport {
  const factory AnalysisReport({
    /// Unique identifier for the report.
    required String id,

    /// The scan record ID this report refers to.
    required String scanId,

    /// The rule ID of the finding being reported.
    required String ruleId,

    /// The finding index in the analysis.
    required int findingIndex,

    /// The user's feedback category.
    required AnalysisReportCategory category,

    /// Optional free-text comment from the user.
    String? comment,

    /// When the report was submitted.
    required DateTime submittedAt,

    /// The analysis version at the time of the report.
    required String analysisVersion,
  }) = _AnalysisReport;

  factory AnalysisReport.fromJson(Map<String, dynamic> json) =>
      _$AnalysisReportFromJson(json);
}

/// Categories for user feedback on analysis findings.
enum AnalysisReportCategory {
  falsePositive,
  missingRisk,
  incorrectSeverity,
  unclearExplanation,
  other;

  String get label {
    switch (this) {
      case AnalysisReportCategory.falsePositive:
        return 'False positive — this warning is not relevant';
      case AnalysisReportCategory.missingRisk:
        return 'Missing risk — a real risk was not detected';
      case AnalysisReportCategory.incorrectSeverity:
        return 'Incorrect severity — the risk level is wrong';
      case AnalysisReportCategory.unclearExplanation:
        return 'Unclear explanation — the wording is confusing';
      case AnalysisReportCategory.other:
        return 'Other issue';
    }
  }
}
