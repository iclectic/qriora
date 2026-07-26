// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'risk_finding.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RiskFinding _$RiskFindingFromJson(Map<String, dynamic> json) {
  return _RiskFinding.fromJson(json);
}

/// @nodoc
mixin _$RiskFinding {
  /// Stable identifier for the rule that produced this finding.
  /// Used for deduplication and for referencing in tests.
  String get ruleId => throw _privateConstructorUsedError;

  /// Severity level of this finding.
  RiskSeverity get severity => throw _privateConstructorUsedError;

  /// Short, human-readable title.
  String get title => throw _privateConstructorUsedError;

  /// Plain-language explanation of why this finding was shown.
  String get explanation => throw _privateConstructorUsedError;

  /// The specific evidence from the payload that caused this finding.
  String get evidence => throw _privateConstructorUsedError;

  /// What the user should do in response.
  String get recommendedResponse => throw _privateConstructorUsedError;

  /// Whether this finding was produced by deterministic rules,
  /// heuristics, or AI supplementation.
  AnalysisMethod get analysisMethod => throw _privateConstructorUsedError;

  /// Version of the rule or engine that produced this finding.
  String get ruleVersion => throw _privateConstructorUsedError;

  /// Serializes this RiskFinding to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RiskFinding
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RiskFindingCopyWith<RiskFinding> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RiskFindingCopyWith<$Res> {
  factory $RiskFindingCopyWith(
    RiskFinding value,
    $Res Function(RiskFinding) then,
  ) = _$RiskFindingCopyWithImpl<$Res, RiskFinding>;
  @useResult
  $Res call({
    String ruleId,
    RiskSeverity severity,
    String title,
    String explanation,
    String evidence,
    String recommendedResponse,
    AnalysisMethod analysisMethod,
    String ruleVersion,
  });
}

/// @nodoc
class _$RiskFindingCopyWithImpl<$Res, $Val extends RiskFinding>
    implements $RiskFindingCopyWith<$Res> {
  _$RiskFindingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RiskFinding
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ruleId = null,
    Object? severity = null,
    Object? title = null,
    Object? explanation = null,
    Object? evidence = null,
    Object? recommendedResponse = null,
    Object? analysisMethod = null,
    Object? ruleVersion = null,
  }) {
    return _then(
      _value.copyWith(
            ruleId: null == ruleId
                ? _value.ruleId
                : ruleId // ignore: cast_nullable_to_non_nullable
                      as String,
            severity: null == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                      as RiskSeverity,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            explanation: null == explanation
                ? _value.explanation
                : explanation // ignore: cast_nullable_to_non_nullable
                      as String,
            evidence: null == evidence
                ? _value.evidence
                : evidence // ignore: cast_nullable_to_non_nullable
                      as String,
            recommendedResponse: null == recommendedResponse
                ? _value.recommendedResponse
                : recommendedResponse // ignore: cast_nullable_to_non_nullable
                      as String,
            analysisMethod: null == analysisMethod
                ? _value.analysisMethod
                : analysisMethod // ignore: cast_nullable_to_non_nullable
                      as AnalysisMethod,
            ruleVersion: null == ruleVersion
                ? _value.ruleVersion
                : ruleVersion // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RiskFindingImplCopyWith<$Res>
    implements $RiskFindingCopyWith<$Res> {
  factory _$$RiskFindingImplCopyWith(
    _$RiskFindingImpl value,
    $Res Function(_$RiskFindingImpl) then,
  ) = __$$RiskFindingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String ruleId,
    RiskSeverity severity,
    String title,
    String explanation,
    String evidence,
    String recommendedResponse,
    AnalysisMethod analysisMethod,
    String ruleVersion,
  });
}

/// @nodoc
class __$$RiskFindingImplCopyWithImpl<$Res>
    extends _$RiskFindingCopyWithImpl<$Res, _$RiskFindingImpl>
    implements _$$RiskFindingImplCopyWith<$Res> {
  __$$RiskFindingImplCopyWithImpl(
    _$RiskFindingImpl _value,
    $Res Function(_$RiskFindingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RiskFinding
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ruleId = null,
    Object? severity = null,
    Object? title = null,
    Object? explanation = null,
    Object? evidence = null,
    Object? recommendedResponse = null,
    Object? analysisMethod = null,
    Object? ruleVersion = null,
  }) {
    return _then(
      _$RiskFindingImpl(
        ruleId: null == ruleId
            ? _value.ruleId
            : ruleId // ignore: cast_nullable_to_non_nullable
                  as String,
        severity: null == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as RiskSeverity,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        explanation: null == explanation
            ? _value.explanation
            : explanation // ignore: cast_nullable_to_non_nullable
                  as String,
        evidence: null == evidence
            ? _value.evidence
            : evidence // ignore: cast_nullable_to_non_nullable
                  as String,
        recommendedResponse: null == recommendedResponse
            ? _value.recommendedResponse
            : recommendedResponse // ignore: cast_nullable_to_non_nullable
                  as String,
        analysisMethod: null == analysisMethod
            ? _value.analysisMethod
            : analysisMethod // ignore: cast_nullable_to_non_nullable
                  as AnalysisMethod,
        ruleVersion: null == ruleVersion
            ? _value.ruleVersion
            : ruleVersion // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RiskFindingImpl implements _RiskFinding {
  const _$RiskFindingImpl({
    required this.ruleId,
    required this.severity,
    required this.title,
    required this.explanation,
    required this.evidence,
    required this.recommendedResponse,
    required this.analysisMethod,
    required this.ruleVersion,
  });

  factory _$RiskFindingImpl.fromJson(Map<String, dynamic> json) =>
      _$$RiskFindingImplFromJson(json);

  /// Stable identifier for the rule that produced this finding.
  /// Used for deduplication and for referencing in tests.
  @override
  final String ruleId;

  /// Severity level of this finding.
  @override
  final RiskSeverity severity;

  /// Short, human-readable title.
  @override
  final String title;

  /// Plain-language explanation of why this finding was shown.
  @override
  final String explanation;

  /// The specific evidence from the payload that caused this finding.
  @override
  final String evidence;

  /// What the user should do in response.
  @override
  final String recommendedResponse;

  /// Whether this finding was produced by deterministic rules,
  /// heuristics, or AI supplementation.
  @override
  final AnalysisMethod analysisMethod;

  /// Version of the rule or engine that produced this finding.
  @override
  final String ruleVersion;

  @override
  String toString() {
    return 'RiskFinding(ruleId: $ruleId, severity: $severity, title: $title, explanation: $explanation, evidence: $evidence, recommendedResponse: $recommendedResponse, analysisMethod: $analysisMethod, ruleVersion: $ruleVersion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RiskFindingImpl &&
            (identical(other.ruleId, ruleId) || other.ruleId == ruleId) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.evidence, evidence) ||
                other.evidence == evidence) &&
            (identical(other.recommendedResponse, recommendedResponse) ||
                other.recommendedResponse == recommendedResponse) &&
            (identical(other.analysisMethod, analysisMethod) ||
                other.analysisMethod == analysisMethod) &&
            (identical(other.ruleVersion, ruleVersion) ||
                other.ruleVersion == ruleVersion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    ruleId,
    severity,
    title,
    explanation,
    evidence,
    recommendedResponse,
    analysisMethod,
    ruleVersion,
  );

  /// Create a copy of RiskFinding
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RiskFindingImplCopyWith<_$RiskFindingImpl> get copyWith =>
      __$$RiskFindingImplCopyWithImpl<_$RiskFindingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RiskFindingImplToJson(this);
  }
}

abstract class _RiskFinding implements RiskFinding {
  const factory _RiskFinding({
    required final String ruleId,
    required final RiskSeverity severity,
    required final String title,
    required final String explanation,
    required final String evidence,
    required final String recommendedResponse,
    required final AnalysisMethod analysisMethod,
    required final String ruleVersion,
  }) = _$RiskFindingImpl;

  factory _RiskFinding.fromJson(Map<String, dynamic> json) =
      _$RiskFindingImpl.fromJson;

  /// Stable identifier for the rule that produced this finding.
  /// Used for deduplication and for referencing in tests.
  @override
  String get ruleId;

  /// Severity level of this finding.
  @override
  RiskSeverity get severity;

  /// Short, human-readable title.
  @override
  String get title;

  /// Plain-language explanation of why this finding was shown.
  @override
  String get explanation;

  /// The specific evidence from the payload that caused this finding.
  @override
  String get evidence;

  /// What the user should do in response.
  @override
  String get recommendedResponse;

  /// Whether this finding was produced by deterministic rules,
  /// heuristics, or AI supplementation.
  @override
  AnalysisMethod get analysisMethod;

  /// Version of the rule or engine that produced this finding.
  @override
  String get ruleVersion;

  /// Create a copy of RiskFinding
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RiskFindingImplCopyWith<_$RiskFindingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
