import 'package:freezed_annotation/freezed_annotation.dart';

part 'extracted_entity.freezed.dart';
part 'extracted_entity.g.dart';

/// The type of entity extracted from a scanned payload.
enum ExtractedEntityType {
  url,
  domain,
  emailAddress,
  phoneNumber,
  ssid,
  password,
  encryptionType,
  contactName,
  organisation,
  phone,
  email,
  address,
  latitude,
  longitude,
  eventTitle,
  eventStart,
  eventEnd,
  eventLocation,
  eventDescription,
  subject,
  body,
  productId,
  text,
  note,
}

extension ExtractedEntityTypeX on ExtractedEntityType {
  String get label {
    switch (this) {
      case ExtractedEntityType.url:
        return 'URL';
      case ExtractedEntityType.domain:
        return 'Domain';
      case ExtractedEntityType.emailAddress:
        return 'Email address';
      case ExtractedEntityType.phoneNumber:
        return 'Phone number';
      case ExtractedEntityType.ssid:
        return 'Network name (SSID)';
      case ExtractedEntityType.password:
        return 'Password';
      case ExtractedEntityType.encryptionType:
        return 'Encryption type';
      case ExtractedEntityType.contactName:
        return 'Contact name';
      case ExtractedEntityType.organisation:
        return 'Organisation';
      case ExtractedEntityType.phone:
        return 'Phone';
      case ExtractedEntityType.email:
        return 'Email';
      case ExtractedEntityType.address:
        return 'Address';
      case ExtractedEntityType.latitude:
        return 'Latitude';
      case ExtractedEntityType.longitude:
        return 'Longitude';
      case ExtractedEntityType.eventTitle:
        return 'Event title';
      case ExtractedEntityType.eventStart:
        return 'Start time';
      case ExtractedEntityType.eventEnd:
        return 'End time';
      case ExtractedEntityType.eventLocation:
        return 'Event location';
      case ExtractedEntityType.eventDescription:
        return 'Event description';
      case ExtractedEntityType.subject:
        return 'Subject';
      case ExtractedEntityType.body:
        return 'Body';
      case ExtractedEntityType.productId:
        return 'Product ID';
      case ExtractedEntityType.text:
        return 'Text';
      case ExtractedEntityType.note:
        return 'Note';
    }
  }

  /// Whether this entity type is sensitive and should be masked by default.
  bool get isSensitive {
    switch (this) {
      case ExtractedEntityType.password:
        return true;
      default:
        return false;
    }
  }
}

@freezed
class ExtractedEntity with _$ExtractedEntity {
  const factory ExtractedEntity({
    required ExtractedEntityType type,
    required String value,
    /// Whether this entity is sensitive and should be masked by default.
    @Default(false) bool isSensitive,
  }) = _ExtractedEntity;

  factory ExtractedEntity.fromJson(Map<String, dynamic> json) =>
      _$ExtractedEntityFromJson(json);
}
