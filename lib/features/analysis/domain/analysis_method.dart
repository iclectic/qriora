/// Indicates whether a finding was produced by deterministic rules
/// or by an optional AI-generated explanation.
enum AnalysisMethod {
  /// Deterministic local rule engine.
  deterministicRule,

  /// Optional AI-generated supplementary explanation.
  aiSupplemented,

  /// Heuristic-based detection.
  heuristic,
}

extension AnalysisMethodX on AnalysisMethod {
  String get label {
    switch (this) {
      case AnalysisMethod.deterministicRule:
        return 'Deterministic rule';
      case AnalysisMethod.aiSupplemented:
        return 'AI-supplemented';
      case AnalysisMethod.heuristic:
        return 'Heuristic';
    }
  }
}
