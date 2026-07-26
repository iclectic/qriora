// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ScanRecord _$ScanRecordFromJson(Map<String, dynamic> json) {
  return _ScanRecord.fromJson(json);
}

/// @nodoc
mixin _$ScanRecord {
  /// Unique identifier.
  String get id => throw _privateConstructorUsedError;

  /// The parsed payload.
  ScanPayload get payload => throw _privateConstructorUsedError;

  /// The source of the scan.
  ScanSource get source => throw _privateConstructorUsedError;

  /// When the scan was performed.
  DateTime get scannedAt => throw _privateConstructorUsedError;

  /// The analysis result.
  AnalysisResult get analysis => throw _privateConstructorUsedError;

  /// Whether this scan is marked as a favourite.
  bool get isFavourite => throw _privateConstructorUsedError;

  /// Optional user note.
  String? get note => throw _privateConstructorUsedError;

  /// Whether the scan contains sensitive content.
  bool get isSensitive => throw _privateConstructorUsedError;

  /// Version of the analysis engine used.
  String get analysisVersion => throw _privateConstructorUsedError;

  /// Serializes this ScanRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScanRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScanRecordCopyWith<ScanRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScanRecordCopyWith<$Res> {
  factory $ScanRecordCopyWith(
    ScanRecord value,
    $Res Function(ScanRecord) then,
  ) = _$ScanRecordCopyWithImpl<$Res, ScanRecord>;
  @useResult
  $Res call({
    String id,
    ScanPayload payload,
    ScanSource source,
    DateTime scannedAt,
    AnalysisResult analysis,
    bool isFavourite,
    String? note,
    bool isSensitive,
    String analysisVersion,
  });

  $ScanPayloadCopyWith<$Res> get payload;
  $AnalysisResultCopyWith<$Res> get analysis;
}

/// @nodoc
class _$ScanRecordCopyWithImpl<$Res, $Val extends ScanRecord>
    implements $ScanRecordCopyWith<$Res> {
  _$ScanRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScanRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? payload = null,
    Object? source = null,
    Object? scannedAt = null,
    Object? analysis = null,
    Object? isFavourite = null,
    Object? note = freezed,
    Object? isSensitive = null,
    Object? analysisVersion = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            payload: null == payload
                ? _value.payload
                : payload // ignore: cast_nullable_to_non_nullable
                      as ScanPayload,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as ScanSource,
            scannedAt: null == scannedAt
                ? _value.scannedAt
                : scannedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            analysis: null == analysis
                ? _value.analysis
                : analysis // ignore: cast_nullable_to_non_nullable
                      as AnalysisResult,
            isFavourite: null == isFavourite
                ? _value.isFavourite
                : isFavourite // ignore: cast_nullable_to_non_nullable
                      as bool,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
            isSensitive: null == isSensitive
                ? _value.isSensitive
                : isSensitive // ignore: cast_nullable_to_non_nullable
                      as bool,
            analysisVersion: null == analysisVersion
                ? _value.analysisVersion
                : analysisVersion // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }

  /// Create a copy of ScanRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ScanPayloadCopyWith<$Res> get payload {
    return $ScanPayloadCopyWith<$Res>(_value.payload, (value) {
      return _then(_value.copyWith(payload: value) as $Val);
    });
  }

  /// Create a copy of ScanRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AnalysisResultCopyWith<$Res> get analysis {
    return $AnalysisResultCopyWith<$Res>(_value.analysis, (value) {
      return _then(_value.copyWith(analysis: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ScanRecordImplCopyWith<$Res>
    implements $ScanRecordCopyWith<$Res> {
  factory _$$ScanRecordImplCopyWith(
    _$ScanRecordImpl value,
    $Res Function(_$ScanRecordImpl) then,
  ) = __$$ScanRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    ScanPayload payload,
    ScanSource source,
    DateTime scannedAt,
    AnalysisResult analysis,
    bool isFavourite,
    String? note,
    bool isSensitive,
    String analysisVersion,
  });

  @override
  $ScanPayloadCopyWith<$Res> get payload;
  @override
  $AnalysisResultCopyWith<$Res> get analysis;
}

/// @nodoc
class __$$ScanRecordImplCopyWithImpl<$Res>
    extends _$ScanRecordCopyWithImpl<$Res, _$ScanRecordImpl>
    implements _$$ScanRecordImplCopyWith<$Res> {
  __$$ScanRecordImplCopyWithImpl(
    _$ScanRecordImpl _value,
    $Res Function(_$ScanRecordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScanRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? payload = null,
    Object? source = null,
    Object? scannedAt = null,
    Object? analysis = null,
    Object? isFavourite = null,
    Object? note = freezed,
    Object? isSensitive = null,
    Object? analysisVersion = null,
  }) {
    return _then(
      _$ScanRecordImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        payload: null == payload
            ? _value.payload
            : payload // ignore: cast_nullable_to_non_nullable
                  as ScanPayload,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as ScanSource,
        scannedAt: null == scannedAt
            ? _value.scannedAt
            : scannedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        analysis: null == analysis
            ? _value.analysis
            : analysis // ignore: cast_nullable_to_non_nullable
                  as AnalysisResult,
        isFavourite: null == isFavourite
            ? _value.isFavourite
            : isFavourite // ignore: cast_nullable_to_non_nullable
                  as bool,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
        isSensitive: null == isSensitive
            ? _value.isSensitive
            : isSensitive // ignore: cast_nullable_to_non_nullable
                  as bool,
        analysisVersion: null == analysisVersion
            ? _value.analysisVersion
            : analysisVersion // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ScanRecordImpl implements _ScanRecord {
  const _$ScanRecordImpl({
    required this.id,
    required this.payload,
    required this.source,
    required this.scannedAt,
    required this.analysis,
    this.isFavourite = false,
    this.note,
    this.isSensitive = false,
    required this.analysisVersion,
  });

  factory _$ScanRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScanRecordImplFromJson(json);

  /// Unique identifier.
  @override
  final String id;

  /// The parsed payload.
  @override
  final ScanPayload payload;

  /// The source of the scan.
  @override
  final ScanSource source;

  /// When the scan was performed.
  @override
  final DateTime scannedAt;

  /// The analysis result.
  @override
  final AnalysisResult analysis;

  /// Whether this scan is marked as a favourite.
  @override
  @JsonKey()
  final bool isFavourite;

  /// Optional user note.
  @override
  final String? note;

  /// Whether the scan contains sensitive content.
  @override
  @JsonKey()
  final bool isSensitive;

  /// Version of the analysis engine used.
  @override
  final String analysisVersion;

  @override
  String toString() {
    return 'ScanRecord(id: $id, payload: $payload, source: $source, scannedAt: $scannedAt, analysis: $analysis, isFavourite: $isFavourite, note: $note, isSensitive: $isSensitive, analysisVersion: $analysisVersion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.scannedAt, scannedAt) ||
                other.scannedAt == scannedAt) &&
            (identical(other.analysis, analysis) ||
                other.analysis == analysis) &&
            (identical(other.isFavourite, isFavourite) ||
                other.isFavourite == isFavourite) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.isSensitive, isSensitive) ||
                other.isSensitive == isSensitive) &&
            (identical(other.analysisVersion, analysisVersion) ||
                other.analysisVersion == analysisVersion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    payload,
    source,
    scannedAt,
    analysis,
    isFavourite,
    note,
    isSensitive,
    analysisVersion,
  );

  /// Create a copy of ScanRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanRecordImplCopyWith<_$ScanRecordImpl> get copyWith =>
      __$$ScanRecordImplCopyWithImpl<_$ScanRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScanRecordImplToJson(this);
  }
}

abstract class _ScanRecord implements ScanRecord {
  const factory _ScanRecord({
    required final String id,
    required final ScanPayload payload,
    required final ScanSource source,
    required final DateTime scannedAt,
    required final AnalysisResult analysis,
    final bool isFavourite,
    final String? note,
    final bool isSensitive,
    required final String analysisVersion,
  }) = _$ScanRecordImpl;

  factory _ScanRecord.fromJson(Map<String, dynamic> json) =
      _$ScanRecordImpl.fromJson;

  /// Unique identifier.
  @override
  String get id;

  /// The parsed payload.
  @override
  ScanPayload get payload;

  /// The source of the scan.
  @override
  ScanSource get source;

  /// When the scan was performed.
  @override
  DateTime get scannedAt;

  /// The analysis result.
  @override
  AnalysisResult get analysis;

  /// Whether this scan is marked as a favourite.
  @override
  bool get isFavourite;

  /// Optional user note.
  @override
  String? get note;

  /// Whether the scan contains sensitive content.
  @override
  bool get isSensitive;

  /// Version of the analysis engine used.
  @override
  String get analysisVersion;

  /// Create a copy of ScanRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScanRecordImplCopyWith<_$ScanRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
