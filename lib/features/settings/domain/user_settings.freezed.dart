// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) {
  return _UserSettings.fromJson(json);
}

/// @nodoc
mixin _$UserSettings {
  /// Theme preference.
  ThemePreference get themePreference => throw _privateConstructorUsedError;

  /// Whether private mode is enabled (scans are never persisted).
  bool get privateMode => throw _privateConstructorUsedError;

  /// Whether biometric lock is enabled.
  bool get biometricLockEnabled => throw _privateConstructorUsedError;

  /// Whether to save scan history.
  bool get saveHistory => throw _privateConstructorUsedError;

  /// Retention policy for scan history.
  RetentionPolicy get retentionPolicy => throw _privateConstructorUsedError;

  /// Whether to mask sensitive values by default.
  bool get maskSensitiveValues => throw _privateConstructorUsedError;

  /// Whether reduced motion is preferred.
  bool get reducedMotion => throw _privateConstructorUsedError;

  /// Whether high contrast is preferred.
  bool get highContrast => throw _privateConstructorUsedError;

  /// Whether large text is preferred.
  bool get largeText => throw _privateConstructorUsedError;

  /// Whether optional network-based lookups are allowed.
  bool get allowNetworkLookups => throw _privateConstructorUsedError;

  /// Whether the user has completed onboarding.
  bool get hasCompletedOnboarding => throw _privateConstructorUsedError;

  /// Whether to deduplicate consecutive scans.
  bool get deduplicateScans => throw _privateConstructorUsedError;

  /// Whether haptic feedback is enabled on scan detection.
  bool get hapticFeedback => throw _privateConstructorUsedError;

  /// Whether sound feedback is enabled on scan detection.
  bool get soundFeedback => throw _privateConstructorUsedError;

  /// Serializes this UserSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSettingsCopyWith<UserSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSettingsCopyWith<$Res> {
  factory $UserSettingsCopyWith(
    UserSettings value,
    $Res Function(UserSettings) then,
  ) = _$UserSettingsCopyWithImpl<$Res, UserSettings>;
  @useResult
  $Res call({
    ThemePreference themePreference,
    bool privateMode,
    bool biometricLockEnabled,
    bool saveHistory,
    RetentionPolicy retentionPolicy,
    bool maskSensitiveValues,
    bool reducedMotion,
    bool highContrast,
    bool largeText,
    bool allowNetworkLookups,
    bool hasCompletedOnboarding,
    bool deduplicateScans,
    bool hapticFeedback,
    bool soundFeedback,
  });

  $RetentionPolicyCopyWith<$Res> get retentionPolicy;
}

/// @nodoc
class _$UserSettingsCopyWithImpl<$Res, $Val extends UserSettings>
    implements $UserSettingsCopyWith<$Res> {
  _$UserSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themePreference = null,
    Object? privateMode = null,
    Object? biometricLockEnabled = null,
    Object? saveHistory = null,
    Object? retentionPolicy = null,
    Object? maskSensitiveValues = null,
    Object? reducedMotion = null,
    Object? highContrast = null,
    Object? largeText = null,
    Object? allowNetworkLookups = null,
    Object? hasCompletedOnboarding = null,
    Object? deduplicateScans = null,
    Object? hapticFeedback = null,
    Object? soundFeedback = null,
  }) {
    return _then(
      _value.copyWith(
            themePreference: null == themePreference
                ? _value.themePreference
                : themePreference // ignore: cast_nullable_to_non_nullable
                      as ThemePreference,
            privateMode: null == privateMode
                ? _value.privateMode
                : privateMode // ignore: cast_nullable_to_non_nullable
                      as bool,
            biometricLockEnabled: null == biometricLockEnabled
                ? _value.biometricLockEnabled
                : biometricLockEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            saveHistory: null == saveHistory
                ? _value.saveHistory
                : saveHistory // ignore: cast_nullable_to_non_nullable
                      as bool,
            retentionPolicy: null == retentionPolicy
                ? _value.retentionPolicy
                : retentionPolicy // ignore: cast_nullable_to_non_nullable
                      as RetentionPolicy,
            maskSensitiveValues: null == maskSensitiveValues
                ? _value.maskSensitiveValues
                : maskSensitiveValues // ignore: cast_nullable_to_non_nullable
                      as bool,
            reducedMotion: null == reducedMotion
                ? _value.reducedMotion
                : reducedMotion // ignore: cast_nullable_to_non_nullable
                      as bool,
            highContrast: null == highContrast
                ? _value.highContrast
                : highContrast // ignore: cast_nullable_to_non_nullable
                      as bool,
            largeText: null == largeText
                ? _value.largeText
                : largeText // ignore: cast_nullable_to_non_nullable
                      as bool,
            allowNetworkLookups: null == allowNetworkLookups
                ? _value.allowNetworkLookups
                : allowNetworkLookups // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasCompletedOnboarding: null == hasCompletedOnboarding
                ? _value.hasCompletedOnboarding
                : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
                      as bool,
            deduplicateScans: null == deduplicateScans
                ? _value.deduplicateScans
                : deduplicateScans // ignore: cast_nullable_to_non_nullable
                      as bool,
            hapticFeedback: null == hapticFeedback
                ? _value.hapticFeedback
                : hapticFeedback // ignore: cast_nullable_to_non_nullable
                      as bool,
            soundFeedback: null == soundFeedback
                ? _value.soundFeedback
                : soundFeedback // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RetentionPolicyCopyWith<$Res> get retentionPolicy {
    return $RetentionPolicyCopyWith<$Res>(_value.retentionPolicy, (value) {
      return _then(_value.copyWith(retentionPolicy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserSettingsImplCopyWith<$Res>
    implements $UserSettingsCopyWith<$Res> {
  factory _$$UserSettingsImplCopyWith(
    _$UserSettingsImpl value,
    $Res Function(_$UserSettingsImpl) then,
  ) = __$$UserSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ThemePreference themePreference,
    bool privateMode,
    bool biometricLockEnabled,
    bool saveHistory,
    RetentionPolicy retentionPolicy,
    bool maskSensitiveValues,
    bool reducedMotion,
    bool highContrast,
    bool largeText,
    bool allowNetworkLookups,
    bool hasCompletedOnboarding,
    bool deduplicateScans,
    bool hapticFeedback,
    bool soundFeedback,
  });

  @override
  $RetentionPolicyCopyWith<$Res> get retentionPolicy;
}

/// @nodoc
class __$$UserSettingsImplCopyWithImpl<$Res>
    extends _$UserSettingsCopyWithImpl<$Res, _$UserSettingsImpl>
    implements _$$UserSettingsImplCopyWith<$Res> {
  __$$UserSettingsImplCopyWithImpl(
    _$UserSettingsImpl _value,
    $Res Function(_$UserSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themePreference = null,
    Object? privateMode = null,
    Object? biometricLockEnabled = null,
    Object? saveHistory = null,
    Object? retentionPolicy = null,
    Object? maskSensitiveValues = null,
    Object? reducedMotion = null,
    Object? highContrast = null,
    Object? largeText = null,
    Object? allowNetworkLookups = null,
    Object? hasCompletedOnboarding = null,
    Object? deduplicateScans = null,
    Object? hapticFeedback = null,
    Object? soundFeedback = null,
  }) {
    return _then(
      _$UserSettingsImpl(
        themePreference: null == themePreference
            ? _value.themePreference
            : themePreference // ignore: cast_nullable_to_non_nullable
                  as ThemePreference,
        privateMode: null == privateMode
            ? _value.privateMode
            : privateMode // ignore: cast_nullable_to_non_nullable
                  as bool,
        biometricLockEnabled: null == biometricLockEnabled
            ? _value.biometricLockEnabled
            : biometricLockEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        saveHistory: null == saveHistory
            ? _value.saveHistory
            : saveHistory // ignore: cast_nullable_to_non_nullable
                  as bool,
        retentionPolicy: null == retentionPolicy
            ? _value.retentionPolicy
            : retentionPolicy // ignore: cast_nullable_to_non_nullable
                  as RetentionPolicy,
        maskSensitiveValues: null == maskSensitiveValues
            ? _value.maskSensitiveValues
            : maskSensitiveValues // ignore: cast_nullable_to_non_nullable
                  as bool,
        reducedMotion: null == reducedMotion
            ? _value.reducedMotion
            : reducedMotion // ignore: cast_nullable_to_non_nullable
                  as bool,
        highContrast: null == highContrast
            ? _value.highContrast
            : highContrast // ignore: cast_nullable_to_non_nullable
                  as bool,
        largeText: null == largeText
            ? _value.largeText
            : largeText // ignore: cast_nullable_to_non_nullable
                  as bool,
        allowNetworkLookups: null == allowNetworkLookups
            ? _value.allowNetworkLookups
            : allowNetworkLookups // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasCompletedOnboarding: null == hasCompletedOnboarding
            ? _value.hasCompletedOnboarding
            : hasCompletedOnboarding // ignore: cast_nullable_to_non_nullable
                  as bool,
        deduplicateScans: null == deduplicateScans
            ? _value.deduplicateScans
            : deduplicateScans // ignore: cast_nullable_to_non_nullable
                  as bool,
        hapticFeedback: null == hapticFeedback
            ? _value.hapticFeedback
            : hapticFeedback // ignore: cast_nullable_to_non_nullable
                  as bool,
        soundFeedback: null == soundFeedback
            ? _value.soundFeedback
            : soundFeedback // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSettingsImpl implements _UserSettings {
  const _$UserSettingsImpl({
    this.themePreference = ThemePreference.system,
    this.privateMode = false,
    this.biometricLockEnabled = false,
    this.saveHistory = true,
    this.retentionPolicy = const RetentionPolicy(
      period: RetentionPeriod.thirtyDays,
    ),
    this.maskSensitiveValues = true,
    this.reducedMotion = false,
    this.highContrast = false,
    this.largeText = false,
    this.allowNetworkLookups = false,
    this.hasCompletedOnboarding = false,
    this.deduplicateScans = true,
    this.hapticFeedback = true,
    this.soundFeedback = false,
  });

  factory _$UserSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSettingsImplFromJson(json);

  /// Theme preference.
  @override
  @JsonKey()
  final ThemePreference themePreference;

  /// Whether private mode is enabled (scans are never persisted).
  @override
  @JsonKey()
  final bool privateMode;

  /// Whether biometric lock is enabled.
  @override
  @JsonKey()
  final bool biometricLockEnabled;

  /// Whether to save scan history.
  @override
  @JsonKey()
  final bool saveHistory;

  /// Retention policy for scan history.
  @override
  @JsonKey()
  final RetentionPolicy retentionPolicy;

  /// Whether to mask sensitive values by default.
  @override
  @JsonKey()
  final bool maskSensitiveValues;

  /// Whether reduced motion is preferred.
  @override
  @JsonKey()
  final bool reducedMotion;

  /// Whether high contrast is preferred.
  @override
  @JsonKey()
  final bool highContrast;

  /// Whether large text is preferred.
  @override
  @JsonKey()
  final bool largeText;

  /// Whether optional network-based lookups are allowed.
  @override
  @JsonKey()
  final bool allowNetworkLookups;

  /// Whether the user has completed onboarding.
  @override
  @JsonKey()
  final bool hasCompletedOnboarding;

  /// Whether to deduplicate consecutive scans.
  @override
  @JsonKey()
  final bool deduplicateScans;

  /// Whether haptic feedback is enabled on scan detection.
  @override
  @JsonKey()
  final bool hapticFeedback;

  /// Whether sound feedback is enabled on scan detection.
  @override
  @JsonKey()
  final bool soundFeedback;

  @override
  String toString() {
    return 'UserSettings(themePreference: $themePreference, privateMode: $privateMode, biometricLockEnabled: $biometricLockEnabled, saveHistory: $saveHistory, retentionPolicy: $retentionPolicy, maskSensitiveValues: $maskSensitiveValues, reducedMotion: $reducedMotion, highContrast: $highContrast, largeText: $largeText, allowNetworkLookups: $allowNetworkLookups, hasCompletedOnboarding: $hasCompletedOnboarding, deduplicateScans: $deduplicateScans, hapticFeedback: $hapticFeedback, soundFeedback: $soundFeedback)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSettingsImpl &&
            (identical(other.themePreference, themePreference) ||
                other.themePreference == themePreference) &&
            (identical(other.privateMode, privateMode) ||
                other.privateMode == privateMode) &&
            (identical(other.biometricLockEnabled, biometricLockEnabled) ||
                other.biometricLockEnabled == biometricLockEnabled) &&
            (identical(other.saveHistory, saveHistory) ||
                other.saveHistory == saveHistory) &&
            (identical(other.retentionPolicy, retentionPolicy) ||
                other.retentionPolicy == retentionPolicy) &&
            (identical(other.maskSensitiveValues, maskSensitiveValues) ||
                other.maskSensitiveValues == maskSensitiveValues) &&
            (identical(other.reducedMotion, reducedMotion) ||
                other.reducedMotion == reducedMotion) &&
            (identical(other.highContrast, highContrast) ||
                other.highContrast == highContrast) &&
            (identical(other.largeText, largeText) ||
                other.largeText == largeText) &&
            (identical(other.allowNetworkLookups, allowNetworkLookups) ||
                other.allowNetworkLookups == allowNetworkLookups) &&
            (identical(other.hasCompletedOnboarding, hasCompletedOnboarding) ||
                other.hasCompletedOnboarding == hasCompletedOnboarding) &&
            (identical(other.deduplicateScans, deduplicateScans) ||
                other.deduplicateScans == deduplicateScans) &&
            (identical(other.hapticFeedback, hapticFeedback) ||
                other.hapticFeedback == hapticFeedback) &&
            (identical(other.soundFeedback, soundFeedback) ||
                other.soundFeedback == soundFeedback));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    themePreference,
    privateMode,
    biometricLockEnabled,
    saveHistory,
    retentionPolicy,
    maskSensitiveValues,
    reducedMotion,
    highContrast,
    largeText,
    allowNetworkLookups,
    hasCompletedOnboarding,
    deduplicateScans,
    hapticFeedback,
    soundFeedback,
  );

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      __$$UserSettingsImplCopyWithImpl<_$UserSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSettingsImplToJson(this);
  }
}

abstract class _UserSettings implements UserSettings {
  const factory _UserSettings({
    final ThemePreference themePreference,
    final bool privateMode,
    final bool biometricLockEnabled,
    final bool saveHistory,
    final RetentionPolicy retentionPolicy,
    final bool maskSensitiveValues,
    final bool reducedMotion,
    final bool highContrast,
    final bool largeText,
    final bool allowNetworkLookups,
    final bool hasCompletedOnboarding,
    final bool deduplicateScans,
    final bool hapticFeedback,
    final bool soundFeedback,
  }) = _$UserSettingsImpl;

  factory _UserSettings.fromJson(Map<String, dynamic> json) =
      _$UserSettingsImpl.fromJson;

  /// Theme preference.
  @override
  ThemePreference get themePreference;

  /// Whether private mode is enabled (scans are never persisted).
  @override
  bool get privateMode;

  /// Whether biometric lock is enabled.
  @override
  bool get biometricLockEnabled;

  /// Whether to save scan history.
  @override
  bool get saveHistory;

  /// Retention policy for scan history.
  @override
  RetentionPolicy get retentionPolicy;

  /// Whether to mask sensitive values by default.
  @override
  bool get maskSensitiveValues;

  /// Whether reduced motion is preferred.
  @override
  bool get reducedMotion;

  /// Whether high contrast is preferred.
  @override
  bool get highContrast;

  /// Whether large text is preferred.
  @override
  bool get largeText;

  /// Whether optional network-based lookups are allowed.
  @override
  bool get allowNetworkLookups;

  /// Whether the user has completed onboarding.
  @override
  bool get hasCompletedOnboarding;

  /// Whether to deduplicate consecutive scans.
  @override
  bool get deduplicateScans;

  /// Whether haptic feedback is enabled on scan detection.
  @override
  bool get hapticFeedback;

  /// Whether sound feedback is enabled on scan detection.
  @override
  bool get soundFeedback;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
