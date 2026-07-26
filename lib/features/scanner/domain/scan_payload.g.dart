// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScanPayloadImpl _$$ScanPayloadImplFromJson(Map<String, dynamic> json) =>
    _$ScanPayloadImpl(
      rawValue: json['rawValue'] as String,
      normalisedValue: json['normalisedValue'] as String,
      contentType: $enumDecode(_$ScanContentTypeEnumMap, json['contentType']),
      barcodeFormat:
          $enumDecodeNullable(_$BarcodeFormatEnumMap, json['barcodeFormat']) ??
          BarcodeFormat.unknown,
      entities:
          (json['entities'] as List<dynamic>?)
              ?.map((e) => ExtractedEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ExtractedEntity>[],
      isSensitive: json['isSensitive'] as bool? ?? false,
    );

Map<String, dynamic> _$$ScanPayloadImplToJson(_$ScanPayloadImpl instance) =>
    <String, dynamic>{
      'rawValue': instance.rawValue,
      'normalisedValue': instance.normalisedValue,
      'contentType': _$ScanContentTypeEnumMap[instance.contentType]!,
      'barcodeFormat': _$BarcodeFormatEnumMap[instance.barcodeFormat]!,
      'entities': instance.entities,
      'isSensitive': instance.isSensitive,
    };

const _$ScanContentTypeEnumMap = {
  ScanContentType.httpsUrl: 'httpsUrl',
  ScanContentType.httpUrl: 'httpUrl',
  ScanContentType.email: 'email',
  ScanContentType.mailto: 'mailto',
  ScanContentType.phoneNumber: 'phoneNumber',
  ScanContentType.tel: 'tel',
  ScanContentType.sms: 'sms',
  ScanContentType.wifi: 'wifi',
  ScanContentType.vCard: 'vCard',
  ScanContentType.meCard: 'meCard',
  ScanContentType.calendarEvent: 'calendarEvent',
  ScanContentType.geoCoordinates: 'geoCoordinates',
  ScanContentType.mapLink: 'mapLink',
  ScanContentType.deepLink: 'deepLink',
  ScanContentType.productBarcode: 'productBarcode',
  ScanContentType.gs1Data: 'gs1Data',
  ScanContentType.plainText: 'plainText',
  ScanContentType.unknown: 'unknown',
  ScanContentType.malformed: 'malformed',
};

const _$BarcodeFormatEnumMap = {
  BarcodeFormat.unknown: 'unknown',
  BarcodeFormat.aztec: 'aztec',
  BarcodeFormat.codabar: 'codabar',
  BarcodeFormat.code39: 'code39',
  BarcodeFormat.code93: 'code93',
  BarcodeFormat.code128: 'code128',
  BarcodeFormat.dataMatrix: 'dataMatrix',
  BarcodeFormat.ean8: 'ean8',
  BarcodeFormat.ean13: 'ean13',
  BarcodeFormat.itf: 'itf',
  BarcodeFormat.maxiCode: 'maxiCode',
  BarcodeFormat.pdf417: 'pdf417',
  BarcodeFormat.qrCode: 'qrCode',
  BarcodeFormat.rss14: 'rss14',
  BarcodeFormat.rssExpanded: 'rssExpanded',
  BarcodeFormat.upcA: 'upcA',
  BarcodeFormat.upcE: 'upcE',
  BarcodeFormat.linear: 'linear',
  BarcodeFormat.matrix: 'matrix',
};
