// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retention_policy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RetentionPolicyImpl _$$RetentionPolicyImplFromJson(
  Map<String, dynamic> json,
) => _$RetentionPolicyImpl(
  period: $enumDecode(_$RetentionPeriodEnumMap, json['period']),
  deleteFavouritesWithHistory:
      json['deleteFavouritesWithHistory'] as bool? ?? false,
);

Map<String, dynamic> _$$RetentionPolicyImplToJson(
  _$RetentionPolicyImpl instance,
) => <String, dynamic>{
  'period': _$RetentionPeriodEnumMap[instance.period]!,
  'deleteFavouritesWithHistory': instance.deleteFavouritesWithHistory,
};

const _$RetentionPeriodEnumMap = {
  RetentionPeriod.never: 'never',
  RetentionPeriod.oneDay: 'oneDay',
  RetentionPeriod.oneWeek: 'oneWeek',
  RetentionPeriod.thirtyDays: 'thirtyDays',
  RetentionPeriod.ninetyDays: 'ninetyDays',
  RetentionPeriod.forever: 'forever',
};
