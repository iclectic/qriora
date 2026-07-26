/// Severity levels for risk findings.
///
/// Risk levels are designed to be communicated through icons, labels,
/// and explanatory text — not colour alone.
enum RiskSeverity {
  /// No issues found. Does NOT mean the content is "safe" — only that
  /// no deterministic rule triggered.
  informational,

  /// Something warrants user attention before proceeding.
  caution,

  /// A significant risk indicator was detected.
  highRisk,

  /// The analysis could not determine the risk level.
  unableToDetermine,
}

extension RiskSeverityX on RiskSeverity {
  String get label {
    switch (this) {
      case RiskSeverity.informational:
        return 'Informational';
      case RiskSeverity.caution:
        return 'Caution';
      case RiskSeverity.highRisk:
        return 'High risk';
      case RiskSeverity.unableToDetermine:
        return 'Unable to determine';
    }
  }

  /// A plain-language description of what this severity means.
  String get explanation {
    switch (this) {
      case RiskSeverity.informational:
        return 'No risk indicators were detected by the local rules. '
            'This does not mean the content is completely safe — only '
            'that no known warning signs were found.';
      case RiskSeverity.caution:
        return 'Some characteristics of this code warrant attention '
            'before you proceed. Review the findings below.';
      case RiskSeverity.highRisk:
        return 'One or more strong risk indicators were detected. '
            'Exercise significant caution before proceeding.';
      case RiskSeverity.unableToDetermine:
        return 'The analysis could not determine the risk level. '
            'Treat the content with caution.';
    }
  }

  /// Sort order for ranking findings (higher = more severe).
  int get sortOrder {
    switch (this) {
      case RiskSeverity.informational:
        return 0;
      case RiskSeverity.unableToDetermine:
        return 1;
      case RiskSeverity.caution:
        return 2;
      case RiskSeverity.highRisk:
        return 3;
    }
  }
}
