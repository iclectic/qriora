// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extracted_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ExtractedEntity _$ExtractedEntityFromJson(Map<String, dynamic> json) {
  return _ExtractedEntity.fromJson(json);
}

/// @nodoc
mixin _$ExtractedEntity {
  ExtractedEntityType get type => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

  /// Whether this entity is sensitive and should be masked by default.
  bool get isSensitive => throw _privateConstructorUsedError;

  /// Serializes this ExtractedEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExtractedEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExtractedEntityCopyWith<ExtractedEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExtractedEntityCopyWith<$Res> {
  factory $ExtractedEntityCopyWith(
    ExtractedEntity value,
    $Res Function(ExtractedEntity) then,
  ) = _$ExtractedEntityCopyWithImpl<$Res, ExtractedEntity>;
  @useResult
  $Res call({ExtractedEntityType type, String value, bool isSensitive});
}

/// @nodoc
class _$ExtractedEntityCopyWithImpl<$Res, $Val extends ExtractedEntity>
    implements $ExtractedEntityCopyWith<$Res> {
  _$ExtractedEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExtractedEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? value = null,
    Object? isSensitive = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ExtractedEntityType,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as String,
            isSensitive: null == isSensitive
                ? _value.isSensitive
                : isSensitive // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExtractedEntityImplCopyWith<$Res>
    implements $ExtractedEntityCopyWith<$Res> {
  factory _$$ExtractedEntityImplCopyWith(
    _$ExtractedEntityImpl value,
    $Res Function(_$ExtractedEntityImpl) then,
  ) = __$$ExtractedEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ExtractedEntityType type, String value, bool isSensitive});
}

/// @nodoc
class __$$ExtractedEntityImplCopyWithImpl<$Res>
    extends _$ExtractedEntityCopyWithImpl<$Res, _$ExtractedEntityImpl>
    implements _$$ExtractedEntityImplCopyWith<$Res> {
  __$$ExtractedEntityImplCopyWithImpl(
    _$ExtractedEntityImpl _value,
    $Res Function(_$ExtractedEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExtractedEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? value = null,
    Object? isSensitive = null,
  }) {
    return _then(
      _$ExtractedEntityImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ExtractedEntityType,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
        isSensitive: null == isSensitive
            ? _value.isSensitive
            : isSensitive // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExtractedEntityImpl implements _ExtractedEntity {
  const _$ExtractedEntityImpl({
    required this.type,
    required this.value,
    this.isSensitive = false,
  });

  factory _$ExtractedEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExtractedEntityImplFromJson(json);

  @override
  final ExtractedEntityType type;
  @override
  final String value;

  /// Whether this entity is sensitive and should be masked by default.
  @override
  @JsonKey()
  final bool isSensitive;

  @override
  String toString() {
    return 'ExtractedEntity(type: $type, value: $value, isSensitive: $isSensitive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExtractedEntityImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.isSensitive, isSensitive) ||
                other.isSensitive == isSensitive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, value, isSensitive);

  /// Create a copy of ExtractedEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExtractedEntityImplCopyWith<_$ExtractedEntityImpl> get copyWith =>
      __$$ExtractedEntityImplCopyWithImpl<_$ExtractedEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ExtractedEntityImplToJson(this);
  }
}

abstract class _ExtractedEntity implements ExtractedEntity {
  const factory _ExtractedEntity({
    required final ExtractedEntityType type,
    required final String value,
    final bool isSensitive,
  }) = _$ExtractedEntityImpl;

  factory _ExtractedEntity.fromJson(Map<String, dynamic> json) =
      _$ExtractedEntityImpl.fromJson;

  @override
  ExtractedEntityType get type;
  @override
  String get value;

  /// Whether this entity is sensitive and should be masked by default.
  @override
  bool get isSensitive;

  /// Create a copy of ExtractedEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExtractedEntityImplCopyWith<_$ExtractedEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
