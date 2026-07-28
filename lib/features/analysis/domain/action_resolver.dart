import '../../scanner/domain/scan_payload.dart';
import '../../scanner/domain/scan_content_type.dart';
import 'suggested_action.dart';
import 'extracted_entity.dart';
import 'deep_link_allowlist.dart';

/// Resolves the list of actions a user can take for a given payload.
///
/// Actions are determined by the content type and the parsed entities.
/// Actions that require confirmation are marked as such by
/// [SuggestedActionType.requiresConfirmation].
class ActionResolver {
  /// Resolves suggested actions for a [ScanPayload].
  List<SuggestedAction> resolve(ScanPayload payload) {
    final actions = <SuggestedAction>[];

    switch (payload.contentType) {
      case ScanContentType.httpsUrl:
      case ScanContentType.httpUrl:
      case ScanContentType.mapLink:
        actions.add(SuggestedAction(
          type: SuggestedActionType.openUrl,
          label: SuggestedActionType.openUrl.label,
          actionValue: payload.normalisedValue,
          isPrimary: true,
        ));
        actions.add(SuggestedAction(
          type: SuggestedActionType.copy,
          label: 'Copy link',
          actionValue: payload.normalisedValue,
        ));
        actions.add(SuggestedAction(
          type: SuggestedActionType.share,
          label: SuggestedActionType.share.label,
          actionValue: payload.normalisedValue,
        ));
        break;

      case ScanContentType.email:
        actions.add(SuggestedAction(
          type: SuggestedActionType.composeEmail,
          label: SuggestedActionType.composeEmail.label,
          actionValue: payload.normalisedValue,
          isPrimary: true,
        ));
        actions.add(SuggestedAction(
          type: SuggestedActionType.copy,
          label: 'Copy email',
          actionValue: payload.normalisedValue,
        ));
        actions.add(SuggestedAction(
          type: SuggestedActionType.share,
          label: SuggestedActionType.share.label,
          actionValue: payload.normalisedValue,
        ));
        break;

      case ScanContentType.mailto:
        actions.add(SuggestedAction(
          type: SuggestedActionType.composeEmail,
          label: SuggestedActionType.composeEmail.label,
          actionValue: payload.normalisedValue,
          isPrimary: true,
        ));
        actions.add(SuggestedAction(
          type: SuggestedActionType.copy,
          label: 'Copy link',
          actionValue: payload.normalisedValue,
        ));
        break;

      case ScanContentType.phoneNumber:
      case ScanContentType.tel:
        final phone = payload.entities
            .where((e) => e.type == ExtractedEntityType.phoneNumber)
            .firstOrNull;
        final value = phone?.value ?? payload.normalisedValue;
        actions.add(SuggestedAction(
          type: SuggestedActionType.callPhone,
          label: SuggestedActionType.callPhone.label,
          actionValue: value,
          isPrimary: true,
        ));
        actions.add(SuggestedAction(
          type: SuggestedActionType.copy,
          label: 'Copy number',
          actionValue: value,
        ));
        actions.add(SuggestedAction(
          type: SuggestedActionType.share,
          label: SuggestedActionType.share.label,
          actionValue: value,
        ));
        break;

      case ScanContentType.sms:
        actions.add(SuggestedAction(
          type: SuggestedActionType.sendSms,
          label: SuggestedActionType.sendSms.label,
          actionValue: payload.normalisedValue,
          isPrimary: true,
        ));
        actions.add(SuggestedAction(
          type: SuggestedActionType.copy,
          label: 'Copy',
          actionValue: payload.normalisedValue,
        ));
        break;

      case ScanContentType.wifi:
        actions.add(SuggestedAction(
          type: SuggestedActionType.joinWifi,
          label: SuggestedActionType.joinWifi.label,
          actionValue: payload.normalisedValue,
          isPrimary: true,
        ));
        actions.add(SuggestedAction(
          type: SuggestedActionType.copy,
          label: 'Copy credentials',
          actionValue: payload.normalisedValue,
        ));
        break;

      case ScanContentType.vCard:
      case ScanContentType.meCard:
        actions.add(SuggestedAction(
          type: SuggestedActionType.saveContact,
          label: SuggestedActionType.saveContact.label,
          actionValue: payload.normalisedValue,
          isPrimary: true,
        ));
        actions.add(SuggestedAction(
          type: SuggestedActionType.copy,
          label: 'Copy details',
          actionValue: payload.normalisedValue,
        ));
        break;

      case ScanContentType.calendarEvent:
        actions.add(SuggestedAction(
          type: SuggestedActionType.addCalendarEvent,
          label: SuggestedActionType.addCalendarEvent.label,
          actionValue: payload.normalisedValue,
          isPrimary: true,
        ));
        actions.add(SuggestedAction(
          type: SuggestedActionType.copy,
          label: 'Copy event',
          actionValue: payload.normalisedValue,
        ));
        break;

      case ScanContentType.geoCoordinates:
        actions.add(SuggestedAction(
          type: SuggestedActionType.openInMap,
          label: SuggestedActionType.openInMap.label,
          actionValue: payload.normalisedValue,
          isPrimary: true,
        ));
        actions.add(SuggestedAction(
          type: SuggestedActionType.copy,
          label: 'Copy location',
          actionValue: payload.normalisedValue,
        ));
        actions.add(SuggestedAction(
          type: SuggestedActionType.share,
          label: SuggestedActionType.share.label,
          actionValue: payload.normalisedValue,
        ));
        break;

      case ScanContentType.deepLink:
        final uri = Uri.tryParse(payload.normalisedValue);
        final isApproved = uri != null && DeepLinkAllowlist.isApprovedUri(uri);
        if (isApproved) {
          actions.add(SuggestedAction(
            type: SuggestedActionType.openUrl,
            label: 'Open link',
            actionValue: payload.normalisedValue,
            isPrimary: true,
          ));
        }
        actions.add(SuggestedAction(
          type: SuggestedActionType.copy,
          label: 'Copy link',
          actionValue: payload.normalisedValue,
        ));
        break;

      case ScanContentType.productBarcode:
      case ScanContentType.gs1Data:
        final productId = payload.entities
            .where((e) => e.type == ExtractedEntityType.productId)
            .firstOrNull;
        actions.add(SuggestedAction(
          type: SuggestedActionType.lookupProduct,
          label: SuggestedActionType.lookupProduct.label,
          actionValue: productId?.value ?? payload.normalisedValue,
          isPrimary: true,
        ));
        actions.add(SuggestedAction(
          type: SuggestedActionType.copy,
          label: 'Copy barcode',
          actionValue: payload.normalisedValue,
        ));
        break;

      case ScanContentType.plainText:
        actions.add(SuggestedAction(
          type: SuggestedActionType.copy,
          label: SuggestedActionType.copy.label,
          actionValue: payload.normalisedValue,
          isPrimary: true,
        ));
        actions.add(SuggestedAction(
          type: SuggestedActionType.share,
          label: SuggestedActionType.share.label,
          actionValue: payload.normalisedValue,
        ));
        break;

      case ScanContentType.unknown:
      case ScanContentType.malformed:
        actions.add(SuggestedAction(
          type: SuggestedActionType.copy,
          label: 'Copy raw value',
          actionValue: payload.rawValue,
        ));
        break;
    }

    // Common actions for all types
    actions.add(SuggestedAction(
      type: SuggestedActionType.saveFavourite,
      label: SuggestedActionType.saveFavourite.label,
    ));
    actions.add(SuggestedAction(
      type: SuggestedActionType.addNote,
      label: SuggestedActionType.addNote.label,
    ));
    actions.add(SuggestedAction(
      type: SuggestedActionType.rescan,
      label: SuggestedActionType.rescan.label,
    ));
    actions.add(SuggestedAction(
      type: SuggestedActionType.dismiss,
      label: SuggestedActionType.dismiss.label,
    ));

    return actions;
  }
}
