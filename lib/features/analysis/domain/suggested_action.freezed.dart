// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'suggested_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SuggestedAction _$SuggestedActionFromJson(Map<String, dynamic> json) {
  return _SuggestedAction.fromJson(json);
}

/// @nodoc
mixin _$SuggestedAction {
  SuggestedActionType get type => throw _privateConstructorUsedError;

  /// The label to display on the action button.
  String get label => throw _privateConstructorUsedError;

  /// The value that will be used when the action is performed
  /// (e.g. the URL to open, the phone number to call).
  String? get actionValue => throw _privateConstructorUsedError;

  /// Whether this action is the primary recommended action.
  bool get isPrimary => throw _privateConstructorUsedError;

  /// Serializes this SuggestedAction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SuggestedAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SuggestedActionCopyWith<SuggestedAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SuggestedActionCopyWith<$Res> {
  factory $SuggestedActionCopyWith(
    SuggestedAction value,
    $Res Function(SuggestedAction) then,
  ) = _$SuggestedActionCopyWithImpl<$Res, SuggestedAction>;
  @useResult
  $Res call({
    SuggestedActionType type,
    String label,
    String? actionValue,
    bool isPrimary,
  });
}

/// @nodoc
class _$SuggestedActionCopyWithImpl<$Res, $Val extends SuggestedAction>
    implements $SuggestedActionCopyWith<$Res> {
  _$SuggestedActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SuggestedAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? label = null,
    Object? actionValue = freezed,
    Object? isPrimary = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as SuggestedActionType,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            actionValue: freezed == actionValue
                ? _value.actionValue
                : actionValue // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPrimary: null == isPrimary
                ? _value.isPrimary
                : isPrimary // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SuggestedActionImplCopyWith<$Res>
    implements $SuggestedActionCopyWith<$Res> {
  factory _$$SuggestedActionImplCopyWith(
    _$SuggestedActionImpl value,
    $Res Function(_$SuggestedActionImpl) then,
  ) = __$$SuggestedActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    SuggestedActionType type,
    String label,
    String? actionValue,
    bool isPrimary,
  });
}

/// @nodoc
class __$$SuggestedActionImplCopyWithImpl<$Res>
    extends _$SuggestedActionCopyWithImpl<$Res, _$SuggestedActionImpl>
    implements _$$SuggestedActionImplCopyWith<$Res> {
  __$$SuggestedActionImplCopyWithImpl(
    _$SuggestedActionImpl _value,
    $Res Function(_$SuggestedActionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SuggestedAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? label = null,
    Object? actionValue = freezed,
    Object? isPrimary = null,
  }) {
    return _then(
      _$SuggestedActionImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as SuggestedActionType,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        actionValue: freezed == actionValue
            ? _value.actionValue
            : actionValue // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPrimary: null == isPrimary
            ? _value.isPrimary
            : isPrimary // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SuggestedActionImpl implements _SuggestedAction {
  const _$SuggestedActionImpl({
    required this.type,
    required this.label,
    this.actionValue,
    this.isPrimary = false,
  });

  factory _$SuggestedActionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SuggestedActionImplFromJson(json);

  @override
  final SuggestedActionType type;

  /// The label to display on the action button.
  @override
  final String label;

  /// The value that will be used when the action is performed
  /// (e.g. the URL to open, the phone number to call).
  @override
  final String? actionValue;

  /// Whether this action is the primary recommended action.
  @override
  @JsonKey()
  final bool isPrimary;

  @override
  String toString() {
    return 'SuggestedAction(type: $type, label: $label, actionValue: $actionValue, isPrimary: $isPrimary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuggestedActionImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.actionValue, actionValue) ||
                other.actionValue == actionValue) &&
            (identical(other.isPrimary, isPrimary) ||
                other.isPrimary == isPrimary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, label, actionValue, isPrimary);

  /// Create a copy of SuggestedAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuggestedActionImplCopyWith<_$SuggestedActionImpl> get copyWith =>
      __$$SuggestedActionImplCopyWithImpl<_$SuggestedActionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SuggestedActionImplToJson(this);
  }
}

abstract class _SuggestedAction implements SuggestedAction {
  const factory _SuggestedAction({
    required final SuggestedActionType type,
    required final String label,
    final String? actionValue,
    final bool isPrimary,
  }) = _$SuggestedActionImpl;

  factory _SuggestedAction.fromJson(Map<String, dynamic> json) =
      _$SuggestedActionImpl.fromJson;

  @override
  SuggestedActionType get type;

  /// The label to display on the action button.
  @override
  String get label;

  /// The value that will be used when the action is performed
  /// (e.g. the URL to open, the phone number to call).
  @override
  String? get actionValue;

  /// Whether this action is the primary recommended action.
  @override
  bool get isPrimary;

  /// Create a copy of SuggestedAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuggestedActionImplCopyWith<_$SuggestedActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
