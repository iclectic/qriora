// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'retention_policy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RetentionPolicy _$RetentionPolicyFromJson(Map<String, dynamic> json) {
  return _RetentionPolicy.fromJson(json);
}

/// @nodoc
mixin _$RetentionPolicy {
  RetentionPeriod get period => throw _privateConstructorUsedError;

  /// Whether to automatically delete favourites when they expire.
  bool get deleteFavouritesWithHistory => throw _privateConstructorUsedError;

  /// Serializes this RetentionPolicy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RetentionPolicy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RetentionPolicyCopyWith<RetentionPolicy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RetentionPolicyCopyWith<$Res> {
  factory $RetentionPolicyCopyWith(
    RetentionPolicy value,
    $Res Function(RetentionPolicy) then,
  ) = _$RetentionPolicyCopyWithImpl<$Res, RetentionPolicy>;
  @useResult
  $Res call({RetentionPeriod period, bool deleteFavouritesWithHistory});
}

/// @nodoc
class _$RetentionPolicyCopyWithImpl<$Res, $Val extends RetentionPolicy>
    implements $RetentionPolicyCopyWith<$Res> {
  _$RetentionPolicyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RetentionPolicy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? deleteFavouritesWithHistory = null,
  }) {
    return _then(
      _value.copyWith(
            period: null == period
                ? _value.period
                : period // ignore: cast_nullable_to_non_nullable
                      as RetentionPeriod,
            deleteFavouritesWithHistory: null == deleteFavouritesWithHistory
                ? _value.deleteFavouritesWithHistory
                : deleteFavouritesWithHistory // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RetentionPolicyImplCopyWith<$Res>
    implements $RetentionPolicyCopyWith<$Res> {
  factory _$$RetentionPolicyImplCopyWith(
    _$RetentionPolicyImpl value,
    $Res Function(_$RetentionPolicyImpl) then,
  ) = __$$RetentionPolicyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({RetentionPeriod period, bool deleteFavouritesWithHistory});
}

/// @nodoc
class __$$RetentionPolicyImplCopyWithImpl<$Res>
    extends _$RetentionPolicyCopyWithImpl<$Res, _$RetentionPolicyImpl>
    implements _$$RetentionPolicyImplCopyWith<$Res> {
  __$$RetentionPolicyImplCopyWithImpl(
    _$RetentionPolicyImpl _value,
    $Res Function(_$RetentionPolicyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RetentionPolicy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? period = null,
    Object? deleteFavouritesWithHistory = null,
  }) {
    return _then(
      _$RetentionPolicyImpl(
        period: null == period
            ? _value.period
            : period // ignore: cast_nullable_to_non_nullable
                  as RetentionPeriod,
        deleteFavouritesWithHistory: null == deleteFavouritesWithHistory
            ? _value.deleteFavouritesWithHistory
            : deleteFavouritesWithHistory // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RetentionPolicyImpl implements _RetentionPolicy {
  const _$RetentionPolicyImpl({
    required this.period,
    this.deleteFavouritesWithHistory = false,
  });

  factory _$RetentionPolicyImpl.fromJson(Map<String, dynamic> json) =>
      _$$RetentionPolicyImplFromJson(json);

  @override
  final RetentionPeriod period;

  /// Whether to automatically delete favourites when they expire.
  @override
  @JsonKey()
  final bool deleteFavouritesWithHistory;

  @override
  String toString() {
    return 'RetentionPolicy(period: $period, deleteFavouritesWithHistory: $deleteFavouritesWithHistory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RetentionPolicyImpl &&
            (identical(other.period, period) || other.period == period) &&
            (identical(
                  other.deleteFavouritesWithHistory,
                  deleteFavouritesWithHistory,
                ) ||
                other.deleteFavouritesWithHistory ==
                    deleteFavouritesWithHistory));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, period, deleteFavouritesWithHistory);

  /// Create a copy of RetentionPolicy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RetentionPolicyImplCopyWith<_$RetentionPolicyImpl> get copyWith =>
      __$$RetentionPolicyImplCopyWithImpl<_$RetentionPolicyImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RetentionPolicyImplToJson(this);
  }
}

abstract class _RetentionPolicy implements RetentionPolicy {
  const factory _RetentionPolicy({
    required final RetentionPeriod period,
    final bool deleteFavouritesWithHistory,
  }) = _$RetentionPolicyImpl;

  factory _RetentionPolicy.fromJson(Map<String, dynamic> json) =
      _$RetentionPolicyImpl.fromJson;

  @override
  RetentionPeriod get period;

  /// Whether to automatically delete favourites when they expire.
  @override
  bool get deleteFavouritesWithHistory;

  /// Create a copy of RetentionPolicy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RetentionPolicyImplCopyWith<_$RetentionPolicyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
