// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ScanPayload _$ScanPayloadFromJson(Map<String, dynamic> json) {
  return _ScanPayload.fromJson(json);
}

/// @nodoc
mixin _$ScanPayload {
  /// The raw value as returned by the scanner.
  String get rawValue => throw _privateConstructorUsedError;

  /// The normalised value (e.g. trimmed, lowercased domain).
  String get normalisedValue => throw _privateConstructorUsedError;

  /// The classified content type.
  ScanContentType get contentType => throw _privateConstructorUsedError;

  /// The barcode format detected by the scanner.
  BarcodeFormat get barcodeFormat => throw _privateConstructorUsedError;

  /// Structured entities extracted from the payload.
  List<ExtractedEntity> get entities => throw _privateConstructorUsedError;

  /// Whether the payload contains sensitive data (e.g. Wi-Fi password).
  bool get isSensitive => throw _privateConstructorUsedError;

  /// Serializes this ScanPayload to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScanPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScanPayloadCopyWith<ScanPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanPayloadCopyWith<$Res> {
  factory $ScanPayloadCopyWith(
    ScanPayload value,
    $Res Function(ScanPayload) then,
  ) = _$ScanPayloadCopyWithImpl<$Res, ScanPayload>;
  @useResult
  $Res call({
    String rawValue,
    String normalisedValue,
    ScanContentType contentType,
    BarcodeFormat barcodeFormat,
    List<ExtractedEntity> entities,
    bool isSensitive,
  });
}

/// @nodoc
class _$ScanPayloadCopyWithImpl<$Res, $Val extends ScanPayload>
    implements $ScanPayloadCopyWith<$Res> {
  _$ScanPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScanPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rawValue = null,
    Object? normalisedValue = null,
    Object? contentType = null,
    Object? barcodeFormat = null,
    Object? entities = null,
    Object? isSensitive = null,
  }) {
    return _then(
      _value.copyWith(
            rawValue: null == rawValue
                ? _value.rawValue
                : rawValue // ignore: cast_nullable_to_non_nullable
                      as String,
            normalisedValue: null == normalisedValue
                ? _value.normalisedValue
                : normalisedValue // ignore: cast_nullable_to_non_nullable
                      as String,
            contentType: null == contentType
                ? _value.contentType
                : contentType // ignore: cast_nullable_to_non_nullable
                      as ScanContentType,
            barcodeFormat: null == barcodeFormat
                ? _value.barcodeFormat
                : barcodeFormat // ignore: cast_nullable_to_non_nullable
                      as BarcodeFormat,
            entities: null == entities
                ? _value.entities
                : entities // ignore: cast_nullable_to_non_nullable
                      as List<ExtractedEntity>,
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
abstract class _$$ScanPayloadImplCopyWith<$Res>
    implements $ScanPayloadCopyWith<$Res> {
  factory _$$ScanPayloadImplCopyWith(
    _$ScanPayloadImpl value,
    $Res Function(_$ScanPayloadImpl) then,
  ) = __$$ScanPayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String rawValue,
    String normalisedValue,
    ScanContentType contentType,
    BarcodeFormat barcodeFormat,
    List<ExtractedEntity> entities,
    bool isSensitive,
  });
}

/// @nodoc
class __$$ScanPayloadImplCopyWithImpl<$Res>
    extends _$ScanPayloadCopyWithImpl<$Res, _$ScanPayloadImpl>
    implements _$$ScanPayloadImplCopyWith<$Res> {
  __$$ScanPayloadImplCopyWithImpl(
    _$ScanPayloadImpl _value,
    $Res Function(_$ScanPayloadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScanPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rawValue = null,
    Object? normalisedValue = null,
    Object? contentType = null,
    Object? barcodeFormat = null,
    Object? entities = null,
    Object? isSensitive = null,
  }) {
    return _then(
      _$ScanPayloadImpl(
        rawValue: null == rawValue
            ? _value.rawValue
            : rawValue // ignore: cast_nullable_to_non_nullable
                  as String,
        normalisedValue: null == normalisedValue
            ? _value.normalisedValue
            : normalisedValue // ignore: cast_nullable_to_non_nullable
                  as String,
        contentType: null == contentType
            ? _value.contentType
            : contentType // ignore: cast_nullable_to_non_nullable
                  as ScanContentType,
        barcodeFormat: null == barcodeFormat
            ? _value.barcodeFormat
            : barcodeFormat // ignore: cast_nullable_to_non_nullable
                  as BarcodeFormat,
        entities: null == entities
            ? _value._entities
            : entities // ignore: cast_nullable_to_non_nullable
                  as List<ExtractedEntity>,
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
class _$ScanPayloadImpl implements _ScanPayload {
  const _$ScanPayloadImpl({
    required this.rawValue,
    required this.normalisedValue,
    required this.contentType,
    this.barcodeFormat = BarcodeFormat.unknown,
    final List<ExtractedEntity> entities = const <ExtractedEntity>[],
    this.isSensitive = false,
  }) : _entities = entities;

  factory _$ScanPayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScanPayloadImplFromJson(json);

  /// The raw value as returned by the scanner.
  @override
  final String rawValue;

  /// The normalised value (e.g. trimmed, lowercased domain).
  @override
  final String normalisedValue;

  /// The classified content type.
  @override
  final ScanContentType contentType;

  /// The barcode format detected by the scanner.
  @override
  @JsonKey()
  final BarcodeFormat barcodeFormat;

  /// Structured entities extracted from the payload.
  final List<ExtractedEntity> _entities;

  /// Structured entities extracted from the payload.
  @override
  @JsonKey()
  List<ExtractedEntity> get entities {
    if (_entities is EqualUnmodifiableListView) return _entities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entities);
  }

  /// Whether the payload contains sensitive data (e.g. Wi-Fi password).
  @override
  @JsonKey()
  final bool isSensitive;

  @override
  String toString() {
    return 'ScanPayload(rawValue: $rawValue, normalisedValue: $normalisedValue, contentType: $contentType, barcodeFormat: $barcodeFormat, entities: $entities, isSensitive: $isSensitive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanPayloadImpl &&
            (identical(other.rawValue, rawValue) ||
                other.rawValue == rawValue) &&
            (identical(other.normalisedValue, normalisedValue) ||
                other.normalisedValue == normalisedValue) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.barcodeFormat, barcodeFormat) ||
                other.barcodeFormat == barcodeFormat) &&
            const DeepCollectionEquality().equals(other._entities, _entities) &&
            (identical(other.isSensitive, isSensitive) ||
                other.isSensitive == isSensitive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    rawValue,
    normalisedValue,
    contentType,
    barcodeFormat,
    const DeepCollectionEquality().hash(_entities),
    isSensitive,
  );

  /// Create a copy of ScanPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanPayloadImplCopyWith<_$ScanPayloadImpl> get copyWith =>
      __$$ScanPayloadImplCopyWithImpl<_$ScanPayloadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScanPayloadImplToJson(this);
  }
}

abstract class _ScanPayload implements ScanPayload {
  const factory _ScanPayload({
    required final String rawValue,
    required final String normalisedValue,
    required final ScanContentType contentType,
    final BarcodeFormat barcodeFormat,
    final List<ExtractedEntity> entities,
    final bool isSensitive,
  }) = _$ScanPayloadImpl;

  factory _ScanPayload.fromJson(Map<String, dynamic> json) =
      _$ScanPayloadImpl.fromJson;

  /// The raw value as returned by the scanner.
  @override
  String get rawValue;

  /// The normalised value (e.g. trimmed, lowercased domain).
  @override
  String get normalisedValue;

  /// The classified content type.
  @override
  ScanContentType get contentType;

  /// The barcode format detected by the scanner.
  @override
  BarcodeFormat get barcodeFormat;

  /// Structured entities extracted from the payload.
  @override
  List<ExtractedEntity> get entities;

  /// Whether the payload contains sensitive data (e.g. Wi-Fi password).
  @override
  bool get isSensitive;

  /// Create a copy of ScanPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScanPayloadImplCopyWith<_$ScanPayloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
