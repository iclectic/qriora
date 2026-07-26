// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserSettingsImpl _$$UserSettingsImplFromJson(Map<String, dynamic> json) =>
    _$UserSettingsImpl(
      themePreference:
          $enumDecodeNullable(
            _$ThemePreferenceEnumMap,
            json['themePreference'],
          ) ??
          ThemePreference.system,
      privateMode: json['privateMode'] as bool? ?? false,
      biometricLockEnabled: json['biometricLockEnabled'] as bool? ?? false,
      saveHistory: json['saveHistory'] as bool? ?? true,
      retentionPolicy: json['retentionPolicy'] == null
          ? const RetentionPolicy(period: RetentionPeriod.thirtyDays)
          : RetentionPolicy.fromJson(
              json['retentionPolicy'] as Map<String, dynamic>,
            ),
      maskSensitiveValues: json['maskSensitiveValues'] as bool? ?? true,
      reducedMotion: json['reducedMotion'] as bool? ?? false,
      highContrast: json['highContrast'] as bool? ?? false,
      largeText: json['largeText'] as bool? ?? false,
      allowNetworkLookups: json['allowNetworkLookups'] as bool? ?? false,
      hasCompletedOnboarding: json['hasCompletedOnboarding'] as bool? ?? false,
      deduplicateScans: json['deduplicateScans'] as bool? ?? true,
    );

Map<String, dynamic> _$$UserSettingsImplToJson(_$UserSettingsImpl instance) =>
    <String, dynamic>{
      'themePreference': _$ThemePreferenceEnumMap[instance.themePreference]!,
      'privateMode': instance.privateMode,
      'biometricLockEnabled': instance.biometricLockEnabled,
      'saveHistory': instance.saveHistory,
      'retentionPolicy': instance.retentionPolicy,
      'maskSensitiveValues': instance.maskSensitiveValues,
      'reducedMotion': instance.reducedMotion,
      'highContrast': instance.highContrast,
      'largeText': instance.largeText,
      'allowNetworkLookups': instance.allowNetworkLookups,
      'hasCompletedOnboarding': instance.hasCompletedOnboarding,
      'deduplicateScans': instance.deduplicateScans,
    };

const _$ThemePreferenceEnumMap = {
  ThemePreference.system: 'system',
  ThemePreference.light: 'light',
  ThemePreference.dark: 'dark',
};
