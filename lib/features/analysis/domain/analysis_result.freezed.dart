// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analysis_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AnalysisResult _$AnalysisResultFromJson(Map<String, dynamic> json) {
  return _AnalysisResult.fromJson(json);
}

/// @nodoc
mixin _$AnalysisResult {
  /// The highest severity among all findings, or [RiskSeverity.informational]
  /// if no findings were produced.
  RiskSeverity get overallSeverity => throw _privateConstructorUsedError;

  /// All risk findings produced by the analysis engine.
  List<RiskFinding> get findings => throw _privateConstructorUsedError;

  /// A plain-language summary of the analysis.
  String get summary => throw _privateConstructorUsedError;

  /// Limitations of the analysis that the user should be aware of.
  List<String> get limitations => throw _privateConstructorUsedError;

  /// The version of the analysis engine that produced this result.
  String get analysisVersion => throw _privateConstructorUsedError;

  /// The method used for analysis.
  AnalysisMethod get analysisMethod => throw _privateConstructorUsedError;

  /// Whether any optional network-based lookup was used.
  bool get usedNetworkLookup => throw _privateConstructorUsedError;

  /// Serializes this AnalysisResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnalysisResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalysisResultCopyWith<AnalysisResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalysisResultCopyWith<$Res> {
  factory $AnalysisResultCopyWith(
    AnalysisResult value,
    $Res Function(AnalysisResult) then,
  ) = _$AnalysisResultCopyWithImpl<$Res, AnalysisResult>;
  @useResult
  $Res call({
    RiskSeverity overallSeverity,
    List<RiskFinding> findings,
    String summary,
    List<String> limitations,
    String analysisVersion,
    AnalysisMethod analysisMethod,
    bool usedNetworkLookup,
  });
}

/// @nodoc
class _$AnalysisResultCopyWithImpl<$Res, $Val extends AnalysisResult>
    implements $AnalysisResultCopyWith<$Res> {
  _$AnalysisResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalysisResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overallSeverity = null,
    Object? findings = null,
    Object? summary = null,
    Object? limitations = null,
    Object? analysisVersion = null,
    Object? analysisMethod = null,
    Object? usedNetworkLookup = null,
  }) {
    return _then(
      _value.copyWith(
            overallSeverity: null == overallSeverity
                ? _value.overallSeverity
                : overallSeverity // ignore: cast_nullable_to_non_nullable
                      as RiskSeverity,
            findings: null == findings
                ? _value.findings
                : findings // ignore: cast_nullable_to_non_nullable
                      as List<RiskFinding>,
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String,
            limitations: null == limitations
                ? _value.limitations
                : limitations // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            analysisVersion: null == analysisVersion
                ? _value.analysisVersion
                : analysisVersion // ignore: cast_nullable_to_non_nullable
                      as String,
            analysisMethod: null == analysisMethod
                ? _value.analysisMethod
                : analysisMethod // ignore: cast_nullable_to_non_nullable
                      as AnalysisMethod,
            usedNetworkLookup: null == usedNetworkLookup
                ? _value.usedNetworkLookup
                : usedNetworkLookup // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnalysisResultImplCopyWith<$Res>
    implements $AnalysisResultCopyWith<$Res> {
  factory _$$AnalysisResultImplCopyWith(
    _$AnalysisResultImpl value,
    $Res Function(_$AnalysisResultImpl) then,
  ) = __$$AnalysisResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    RiskSeverity overallSeverity,
    List<RiskFinding> findings,
    String summary,
    List<String> limitations,
    String analysisVersion,
    AnalysisMethod analysisMethod,
    bool usedNetworkLookup,
  });
}

/// @nodoc
class __$$AnalysisResultImplCopyWithImpl<$Res>
    extends _$AnalysisResultCopyWithImpl<$Res, _$AnalysisResultImpl>
    implements _$$AnalysisResultImplCopyWith<$Res> {
  __$$AnalysisResultImplCopyWithImpl(
    _$AnalysisResultImpl _value,
    $Res Function(_$AnalysisResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnalysisResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overallSeverity = null,
    Object? findings = null,
    Object? summary = null,
    Object? limitations = null,
    Object? analysisVersion = null,
    Object? analysisMethod = null,
    Object? usedNetworkLookup = null,
  }) {
    return _then(
      _$AnalysisResultImpl(
        overallSeverity: null == overallSeverity
            ? _value.overallSeverity
            : overallSeverity // ignore: cast_nullable_to_non_nullable
                  as RiskSeverity,
        findings: null == findings
            ? _value._findings
            : findings // ignore: cast_nullable_to_non_nullable
                  as List<RiskFinding>,
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String,
        limitations: null == limitations
            ? _value._limitations
            : limitations // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        analysisVersion: null == analysisVersion
            ? _value.analysisVersion
            : analysisVersion // ignore: cast_nullable_to_non_nullable
                  as String,
        analysisMethod: null == analysisMethod
            ? _value.analysisMethod
            : analysisMethod // ignore: cast_nullable_to_non_nullable
                  as AnalysisMethod,
        usedNetworkLookup: null == usedNetworkLookup
            ? _value.usedNetworkLookup
            : usedNetworkLookup // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalysisResultImpl implements _AnalysisResult {
  const _$AnalysisResultImpl({
    required this.overallSeverity,
    final List<RiskFinding> findings = const <RiskFinding>[],
    required this.summary,
    final List<String> limitations = const <String>[],
    required this.analysisVersion,
    required this.analysisMethod,
    this.usedNetworkLookup = false,
  }) : _findings = findings,
       _limitations = limitations;

  factory _$AnalysisResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalysisResultImplFromJson(json);

  /// The highest severity among all findings, or [RiskSeverity.informational]
  /// if no findings were produced.
  @override
  final RiskSeverity overallSeverity;

  /// All risk findings produced by the analysis engine.
  final List<RiskFinding> _findings;

  /// All risk findings produced by the analysis engine.
  @override
  @JsonKey()
  List<RiskFinding> get findings {
    if (_findings is EqualUnmodifiableListView) return _findings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_findings);
  }

  /// A plain-language summary of the analysis.
  @override
  final String summary;

  /// Limitations of the analysis that the user should be aware of.
  final List<String> _limitations;

  /// Limitations of the analysis that the user should be aware of.
  @override
  @JsonKey()
  List<String> get limitations {
    if (_limitations is EqualUnmodifiableListView) return _limitations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_limitations);
  }

  /// The version of the analysis engine that produced this result.
  @override
  final String analysisVersion;

  /// The method used for analysis.
  @override
  final AnalysisMethod analysisMethod;

  /// Whether any optional network-based lookup was used.
  @override
  @JsonKey()
  final bool usedNetworkLookup;

  @override
  String toString() {
    return 'AnalysisResult(overallSeverity: $overallSeverity, findings: $findings, summary: $summary, limitations: $limitations, analysisVersion: $analysisVersion, analysisMethod: $analysisMethod, usedNetworkLookup: $usedNetworkLookup)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalysisResultImpl &&
            (identical(other.overallSeverity, overallSeverity) ||
                other.overallSeverity == overallSeverity) &&
            const DeepCollectionEquality().equals(other._findings, _findings) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(
              other._limitations,
              _limitations,
            ) &&
            (identical(other.analysisVersion, analysisVersion) ||
                other.analysisVersion == analysisVersion) &&
            (identical(other.analysisMethod, analysisMethod) ||
                other.analysisMethod == analysisMethod) &&
            (identical(other.usedNetworkLookup, usedNetworkLookup) ||
                other.usedNetworkLookup == usedNetworkLookup));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    overallSeverity,
    const DeepCollectionEquality().hash(_findings),
    summary,
    const DeepCollectionEquality().hash(_limitations),
    analysisVersion,
    analysisMethod,
    usedNetworkLookup,
  );

  /// Create a copy of AnalysisResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalysisResultImplCopyWith<_$AnalysisResultImpl> get copyWith =>
      __$$AnalysisResultImplCopyWithImpl<_$AnalysisResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalysisResultImplToJson(this);
  }
}

abstract class _AnalysisResult implements AnalysisResult {
  const factory _AnalysisResult({
    required final RiskSeverity overallSeverity,
    final List<RiskFinding> findings,
    required final String summary,
    final List<String> limitations,
    required final String analysisVersion,
    required final AnalysisMethod analysisMethod,
    final bool usedNetworkLookup,
  }) = _$AnalysisResultImpl;

  factory _AnalysisResult.fromJson(Map<String, dynamic> json) =
      _$AnalysisResultImpl.fromJson;

  /// The highest severity among all findings, or [RiskSeverity.informational]
  /// if no findings were produced.
  @override
  RiskSeverity get overallSeverity;

  /// All risk findings produced by the analysis engine.
  @override
  List<RiskFinding> get findings;

  /// A plain-language summary of the analysis.
  @override
  String get summary;

  /// Limitations of the analysis that the user should be aware of.
  @override
  List<String> get limitations;

  /// The version of the analysis engine that produced this result.
  @override
  String get analysisVersion;

  /// The method used for analysis.
  @override
  AnalysisMethod get analysisMethod;

  /// Whether any optional network-based lookup was used.
  @override
  bool get usedNetworkLookup;

  /// Create a copy of AnalysisResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalysisResultImplCopyWith<_$AnalysisResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
