import 'package:freezed_annotation/freezed_annotation.dart';

import 'retention_policy.dart';

part 'user_settings.freezed.dart';
part 'user_settings.g.dart';

/// The theme mode preference.
enum ThemePreference {
  system,
  light,
  dark,
}

extension ThemePreferenceX on ThemePreference {
  String get label {
    switch (this) {
      case ThemePreference.system:
        return 'System default';
      case ThemePreference.light:
        return 'Light';
      case ThemePreference.dark:
        return 'Dark';
    }
  }
}

/// User-configurable application settings.
@freezed
class UserSettings with _$UserSettings {
  const factory UserSettings({
    /// Theme preference.
    @Default(ThemePreference.system) ThemePreference themePreference,

    /// Whether private mode is enabled (scans are never persisted).
    @Default(false) bool privateMode,

    /// Whether biometric lock is enabled.
    @Default(false) bool biometricLockEnabled,

    /// Whether to save scan history.
    @Default(true) bool saveHistory,

    /// Retention policy for scan history.
    @Default(RetentionPolicy(period: RetentionPeriod.thirtyDays))
    RetentionPolicy retentionPolicy,

    /// Whether to mask sensitive values by default.
    @Default(true) bool maskSensitiveValues,

    /// Whether reduced motion is preferred.
    @Default(false) bool reducedMotion,

    /// Whether high contrast is preferred.
    @Default(false) bool highContrast,

    /// Whether large text is preferred.
    @Default(false) bool largeText,

    /// Whether optional network-based lookups are allowed.
    @Default(false) bool allowNetworkLookups,

    /// Whether the user has completed onboarding.
    @Default(false) bool hasCompletedOnboarding,

    /// Whether to deduplicate consecutive scans.
    @Default(true) bool deduplicateScans,

    /// Whether haptic feedback is enabled on scan detection.
    @Default(true) bool hapticFeedback,

    /// Whether sound feedback is enabled on scan detection.
    @Default(false) bool soundFeedback,
  }) = _UserSettings;

  factory UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);
}
