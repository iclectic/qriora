// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extracted_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExtractedEntityImpl _$$ExtractedEntityImplFromJson(
  Map<String, dynamic> json,
) => _$ExtractedEntityImpl(
  type: $enumDecode(_$ExtractedEntityTypeEnumMap, json['type']),
  value: json['value'] as String,
  isSensitive: json['isSensitive'] as bool? ?? false,
);

Map<String, dynamic> _$$ExtractedEntityImplToJson(
  _$ExtractedEntityImpl instance,
) => <String, dynamic>{
  'type': _$ExtractedEntityTypeEnumMap[instance.type]!,
  'value': instance.value,
  'isSensitive': instance.isSensitive,
};

const _$ExtractedEntityTypeEnumMap = {
  ExtractedEntityType.url: 'url',
  ExtractedEntityType.domain: 'domain',
  ExtractedEntityType.emailAddress: 'emailAddress',
  ExtractedEntityType.phoneNumber: 'phoneNumber',
  ExtractedEntityType.ssid: 'ssid',
  ExtractedEntityType.password: 'password',
  ExtractedEntityType.encryptionType: 'encryptionType',
  ExtractedEntityType.contactName: 'contactName',
  ExtractedEntityType.organisation: 'organisation',
  ExtractedEntityType.phone: 'phone',
  ExtractedEntityType.email: 'email',
  ExtractedEntityType.address: 'address',
  ExtractedEntityType.latitude: 'latitude',
  ExtractedEntityType.longitude: 'longitude',
  ExtractedEntityType.eventTitle: 'eventTitle',
  ExtractedEntityType.eventStart: 'eventStart',
  ExtractedEntityType.eventEnd: 'eventEnd',
  ExtractedEntityType.eventLocation: 'eventLocation',
  ExtractedEntityType.eventDescription: 'eventDescription',
  ExtractedEntityType.subject: 'subject',
  ExtractedEntityType.body: 'body',
  ExtractedEntityType.productId: 'productId',
  ExtractedEntityType.text: 'text',
  ExtractedEntityType.note: 'note',
};
