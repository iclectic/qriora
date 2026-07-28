// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analysis_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AnalysisReport _$AnalysisReportFromJson(Map<String, dynamic> json) {
  return _AnalysisReport.fromJson(json);
}

/// @nodoc
mixin _$AnalysisReport {
  /// Unique identifier for the report.
  String get id => throw _privateConstructorUsedError;

  /// The scan record ID this report refers to.
  String get scanId => throw _privateConstructorUsedError;

  /// The rule ID of the finding being reported.
  String get ruleId => throw _privateConstructorUsedError;

  /// The finding index in the analysis.
  int get findingIndex => throw _privateConstructorUsedError;

  /// The user's feedback category.
  AnalysisReportCategory get category => throw _privateConstructorUsedError;

  /// Optional free-text comment from the user.
  String? get comment => throw _privateConstructorUsedError;

  /// When the report was submitted.
  DateTime get submittedAt => throw _privateConstructorUsedError;

  /// The analysis version at the time of the report.
  String get analysisVersion => throw _privateConstructorUsedError;

  /// Serializes this AnalysisReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnalysisReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalysisReportCopyWith<AnalysisReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalysisReportCopyWith<$Res> {
  factory $AnalysisReportCopyWith(
    AnalysisReport value,
    $Res Function(AnalysisReport) then,
  ) = _$AnalysisReportCopyWithImpl<$Res, AnalysisReport>;
  @useResult
  $Res call({
    String id,
    String scanId,
    String ruleId,
    int findingIndex,
    AnalysisReportCategory category,
    String? comment,
    DateTime submittedAt,
    String analysisVersion,
  });
}

/// @nodoc
class _$AnalysisReportCopyWithImpl<$Res, $Val extends AnalysisReport>
    implements $AnalysisReportCopyWith<$Res> {
  _$AnalysisReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalysisReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scanId = null,
    Object? ruleId = null,
    Object? findingIndex = null,
    Object? category = null,
    Object? comment = freezed,
    Object? submittedAt = null,
    Object? analysisVersion = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            scanId: null == scanId
                ? _value.scanId
                : scanId // ignore: cast_nullable_to_non_nullable
                      as String,
            ruleId: null == ruleId
                ? _value.ruleId
                : ruleId // ignore: cast_nullable_to_non_nullable
                      as String,
            findingIndex: null == findingIndex
                ? _value.findingIndex
                : findingIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as AnalysisReportCategory,
            comment: freezed == comment
                ? _value.comment
                : comment // ignore: cast_nullable_to_non_nullable
                      as String?,
            submittedAt: null == submittedAt
                ? _value.submittedAt
                : submittedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            analysisVersion: null == analysisVersion
                ? _value.analysisVersion
                : analysisVersion // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnalysisReportImplCopyWith<$Res>
    implements $AnalysisReportCopyWith<$Res> {
  factory _$$AnalysisReportImplCopyWith(
    _$AnalysisReportImpl value,
    $Res Function(_$AnalysisReportImpl) then,
  ) = __$$AnalysisReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String scanId,
    String ruleId,
    int findingIndex,
    AnalysisReportCategory category,
    String? comment,
    DateTime submittedAt,
    String analysisVersion,
  });
}

/// @nodoc
class __$$AnalysisReportImplCopyWithImpl<$Res>
    extends _$AnalysisReportCopyWithImpl<$Res, _$AnalysisReportImpl>
    implements _$$AnalysisReportImplCopyWith<$Res> {
  __$$AnalysisReportImplCopyWithImpl(
    _$AnalysisReportImpl _value,
    $Res Function(_$AnalysisReportImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnalysisReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scanId = null,
    Object? ruleId = null,
    Object? findingIndex = null,
    Object? category = null,
    Object? comment = freezed,
    Object? submittedAt = null,
    Object? analysisVersion = null,
  }) {
    return _then(
      _$AnalysisReportImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        scanId: null == scanId
            ? _value.scanId
            : scanId // ignore: cast_nullable_to_non_nullable
                  as String,
        ruleId: null == ruleId
            ? _value.ruleId
            : ruleId // ignore: cast_nullable_to_non_nullable
                  as String,
        findingIndex: null == findingIndex
            ? _value.findingIndex
            : findingIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as AnalysisReportCategory,
        comment: freezed == comment
            ? _value.comment
            : comment // ignore: cast_nullable_to_non_nullable
                  as String?,
        submittedAt: null == submittedAt
            ? _value.submittedAt
            : submittedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
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
class _$AnalysisReportImpl implements _AnalysisReport {
  const _$AnalysisReportImpl({
    required this.id,
    required this.scanId,
    required this.ruleId,
    required this.findingIndex,
    required this.category,
    this.comment,
    required this.submittedAt,
    required this.analysisVersion,
  });

  factory _$AnalysisReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalysisReportImplFromJson(json);

  /// Unique identifier for the report.
  @override
  final String id;

  /// The scan record ID this report refers to.
  @override
  final String scanId;

  /// The rule ID of the finding being reported.
  @override
  final String ruleId;

  /// The finding index in the analysis.
  @override
  final int findingIndex;

  /// The user's feedback category.
  @override
  final AnalysisReportCategory category;

  /// Optional free-text comment from the user.
  @override
  final String? comment;

  /// When the report was submitted.
  @override
  final DateTime submittedAt;

  /// The analysis version at the time of the report.
  @override
  final String analysisVersion;

  @override
  String toString() {
    return 'AnalysisReport(id: $id, scanId: $scanId, ruleId: $ruleId, findingIndex: $findingIndex, category: $category, comment: $comment, submittedAt: $submittedAt, analysisVersion: $analysisVersion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalysisReportImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.scanId, scanId) || other.scanId == scanId) &&
            (identical(other.ruleId, ruleId) || other.ruleId == ruleId) &&
            (identical(other.findingIndex, findingIndex) ||
                other.findingIndex == findingIndex) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.analysisVersion, analysisVersion) ||
                other.analysisVersion == analysisVersion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    scanId,
    ruleId,
    findingIndex,
    category,
    comment,
    submittedAt,
    analysisVersion,
  );

  /// Create a copy of AnalysisReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalysisReportImplCopyWith<_$AnalysisReportImpl> get copyWith =>
      __$$AnalysisReportImplCopyWithImpl<_$AnalysisReportImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalysisReportImplToJson(this);
  }
}

abstract class _AnalysisReport implements AnalysisReport {
  const factory _AnalysisReport({
    required final String id,
    required final String scanId,
    required final String ruleId,
    required final int findingIndex,
    required final AnalysisReportCategory category,
    final String? comment,
    required final DateTime submittedAt,
    required final String analysisVersion,
  }) = _$AnalysisReportImpl;

  factory _AnalysisReport.fromJson(Map<String, dynamic> json) =
      _$AnalysisReportImpl.fromJson;

  /// Unique identifier for the report.
  @override
  String get id;

  /// The scan record ID this report refers to.
  @override
  String get scanId;

  /// The rule ID of the finding being reported.
  @override
  String get ruleId;

  /// The finding index in the analysis.
  @override
  int get findingIndex;

  /// The user's feedback category.
  @override
  AnalysisReportCategory get category;

  /// Optional free-text comment from the user.
  @override
  String? get comment;

  /// When the report was submitted.
  @override
  DateTime get submittedAt;

  /// The analysis version at the time of the report.
  @override
  String get analysisVersion;

  /// Create a copy of AnalysisReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalysisReportImplCopyWith<_$AnalysisReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
