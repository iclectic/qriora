import 'package:flutter/material.dart';

/// Utility helpers for applying accessibility semantics consistently
/// across the Qriora app.
class QrioraSemantics {
  QrioraSemantics._();

  /// Wraps a widget with a semantic label for screen readers.
  ///
  /// Use this for icon-only buttons or non-text interactive elements.
  static Widget labelled({
    required String label,
    required Widget child,
    bool button = false,
    bool enabled = true,
    String? hint,
    VoidCallback? onTap,
  }) {
    return Semantics(
      label: label,
      hint: hint,
      button: button,
      enabled: enabled,
      child: child,
    );
  }

  /// Wraps a widget with a header semantic to mark it as a section heading.
  static Widget header({
    required String label,
    required Widget child,
  }) {
    return Semantics(
      header: true,
      label: label,
      child: child,
    );
  }

  /// Wraps a widget with a live region semantic so that screen readers
  /// announce changes to its content.
  static Widget liveRegion({
    required Widget child,
    bool polite = true,
  }) {
    return Semantics(
      liveRegion: true,
      child: child,
    );
  }

  /// Wraps a widget describing risk severity with an accessible label
  /// that includes both the severity level and the finding title.
  static Widget severityBadge({
    required String severityLabel,
    required String findingTitle,
    required Widget child,
  }) {
    return Semantics(
      label: '$severityLabel risk: $findingTitle',
      child: child,
    );
  }
}

/// A focus traversal policy that ensures a logical reading order
/// for the scan result screen: top-to-bottom, left-to-right.
class QrioraFocusTraversalPolicy extends ReadingOrderTraversalPolicy {
  /// Default focus order for the app.
  static Widget wrap(Widget child) {
    return FocusTraversalGroup(
      policy: QrioraFocusTraversalPolicy(),
      child: child,
    );
  }
}
