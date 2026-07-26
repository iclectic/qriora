// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggested_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SuggestedActionImpl _$$SuggestedActionImplFromJson(
  Map<String, dynamic> json,
) => _$SuggestedActionImpl(
  type: $enumDecode(_$SuggestedActionTypeEnumMap, json['type']),
  label: json['label'] as String,
  actionValue: json['actionValue'] as String?,
  isPrimary: json['isPrimary'] as bool? ?? false,
);

Map<String, dynamic> _$$SuggestedActionImplToJson(
  _$SuggestedActionImpl instance,
) => <String, dynamic>{
  'type': _$SuggestedActionTypeEnumMap[instance.type]!,
  'label': instance.label,
  'actionValue': instance.actionValue,
  'isPrimary': instance.isPrimary,
};

const _$SuggestedActionTypeEnumMap = {
  SuggestedActionType.openUrl: 'openUrl',
  SuggestedActionType.copy: 'copy',
  SuggestedActionType.share: 'share',
  SuggestedActionType.saveFavourite: 'saveFavourite',
  SuggestedActionType.addNote: 'addNote',
  SuggestedActionType.dismiss: 'dismiss',
  SuggestedActionType.joinWifi: 'joinWifi',
  SuggestedActionType.callPhone: 'callPhone',
  SuggestedActionType.sendSms: 'sendSms',
  SuggestedActionType.composeEmail: 'composeEmail',
  SuggestedActionType.saveContact: 'saveContact',
  SuggestedActionType.addCalendarEvent: 'addCalendarEvent',
  SuggestedActionType.openInMap: 'openInMap',
  SuggestedActionType.lookupProduct: 'lookupProduct',
  SuggestedActionType.rescan: 'rescan',
};
