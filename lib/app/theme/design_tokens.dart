import 'package:flutter/material.dart';

/// Reusable design tokens for the Qriora visual language.
///
/// These tokens centralise colours, spacing, radii, and durations
/// so that themes and widgets reference a single source of truth.
class QrioraDesignTokens {
  QrioraDesignTokens._();

  // --- Brand colours ---

  /// Primary brand colour — a calm teal that communicates trust and safety.
  static const Color primaryBrand = Color(0xFF2D6A6F);

  /// High-contrast light variant.
  static const Color primaryBrandHighContrastLight = Color(0xFF005F5F);

  /// High-contrast dark variant.
  static const Color primaryBrandHighContrastDark = Color(0xFF7CD6D6);

  // --- Severity colours (never used alone — always paired with icon + label) ---

  /// Informational severity — neutral.
  static const Color severityInformational = Color(0xFF6B7280);

  /// Caution severity — amber.
  static const Color severityCaution = Color(0xFFD97706);

  /// High risk severity — deep orange.
  static const Color severityHighRisk = Color(0xFFDC2626);

  /// Unable to determine — purple-grey.
  static const Color severityUnableToDetermine = Color(0xFF7C3AED);

  // --- Spacing ---

  static const double spaceXs = 4;
  static const double spaceSm = 8;
  static const double spaceMd = 16;
  static const double spaceLg = 24;
  static const double spaceXl = 32;
  static const double spaceXxl = 48;

  // --- Radii ---

  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;

  // --- Durations ---

  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationMedium = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);

  // --- Scanner overlay ---

  static const double scanAreaSize = 250;
  static const double scanAreaRadius = 16;

  // --- Content limits ---

  /// Maximum payload length accepted by the parser.
  static const int maxPayloadLength = 10000;
}
