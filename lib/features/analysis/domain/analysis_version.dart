/// Version of the analysis engine that produced a result.
///
/// Used to track which version of the rules were applied so that
/// historical results can be re-evaluated if the engine is updated.
class AnalysisVersion {
  final int major;
  final int minor;
  final int patch;

  const AnalysisVersion({
    this.major = 1,
    this.minor = 0,
    this.patch = 0,
  });

  String get versionString => '$major.$minor.$patch';

  @override
  String toString() => versionString;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnalysisVersion &&
          major == other.major &&
          minor == other.minor &&
          patch == other.patch;

  @override
  int get hashCode => Object.hash(major, minor, patch);
}
