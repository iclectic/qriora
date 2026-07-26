import 'package:freezed_annotation/freezed_annotation.dart';

import 'risk_finding.dart';
import 'risk_severity.dart';
import 'analysis_method.dart';

part 'analysis_result.freezed.dart';
part 'analysis_result.g.dart';

/// The overall result of analysing a scanned payload.
@freezed
class AnalysisResult with _$AnalysisResult {
  const factory AnalysisResult({
    /// The highest severity among all findings, or [RiskSeverity.informational]
    /// if no findings were produced.
    required RiskSeverity overallSeverity,

    /// All risk findings produced by the analysis engine.
    @Default(<RiskFinding>[]) List<RiskFinding> findings,

    /// A plain-language summary of the analysis.
    required String summary,

    /// Limitations of the analysis that the user should be aware of.
    @Default(<String>[]) List<String> limitations,

    /// The version of the analysis engine that produced this result.
    required String analysisVersion,

    /// The method used for analysis.
    required AnalysisMethod analysisMethod,

    /// Whether any optional network-based lookup was used.
    @Default(false) bool usedNetworkLookup,
  }) = _AnalysisResult;

  factory AnalysisResult.fromJson(Map<String, dynamic> json) =>
      _$AnalysisResultFromJson(json);
}
