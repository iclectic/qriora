import 'package:freezed_annotation/freezed_annotation.dart';

part 'retention_policy.freezed.dart';
part 'retention_policy.g.dart';

/// How long scan history is retained before automatic deletion.
enum RetentionPeriod {
  /// Never retain scan history.
  never,
  /// Retain for 24 hours.
  oneDay,
  /// Retain for 7 days.
  oneWeek,
  /// Retain for 30 days.
  thirtyDays,
  /// Retain for 90 days.
  ninetyDays,
  /// Retain indefinitely (until manually deleted).
  forever,
}

extension RetentionPeriodX on RetentionPeriod {
  String get label {
    switch (this) {
      case RetentionPeriod.never:
        return 'Never save history';
      case RetentionPeriod.oneDay:
        return '24 hours';
      case RetentionPeriod.oneWeek:
        return '7 days';
      case RetentionPeriod.thirtyDays:
        return '30 days';
      case RetentionPeriod.ninetyDays:
        return '90 days';
      case RetentionPeriod.forever:
        return 'Keep indefinitely';
    }
  }

  /// The retention duration as a [Duration], or null for "forever".
  Duration? get duration {
    switch (this) {
      case RetentionPeriod.never:
        return Duration.zero;
      case RetentionPeriod.oneDay:
        return const Duration(days: 1);
      case RetentionPeriod.oneWeek:
        return const Duration(days: 7);
      case RetentionPeriod.thirtyDays:
        return const Duration(days: 30);
      case RetentionPeriod.ninetyDays:
        return const Duration(days: 90);
      case RetentionPeriod.forever:
        return null;
    }
  }
}

@freezed
class RetentionPolicy with _$RetentionPolicy {
  const factory RetentionPolicy({
    required RetentionPeriod period,
    /// Whether to automatically delete favourites when they expire.
    @Default(false) bool deleteFavouritesWithHistory,
  }) = _RetentionPolicy;

  factory RetentionPolicy.fromJson(Map<String, dynamic> json) =>
      _$RetentionPolicyFromJson(json);
}
