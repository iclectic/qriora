import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'suggested_action.freezed.dart';
part 'suggested_action.g.dart';

/// The type of action a user can take on a scanned result.
enum SuggestedActionType {
  /// Open a URL in the browser (requires confirmation).
  openUrl,
  /// Copy the raw value or a specific field to the clipboard.
  copy,
  /// Share the content via the system share sheet.
  share,
  /// Save the scan to favourites.
  saveFavourite,
  /// Add a note to the scan record.
  addNote,
  /// Dismiss the result without taking action.
  dismiss,
  /// Join a Wi-Fi network (requires confirmation).
  joinWifi,
  /// Initiate a phone call (requires confirmation).
  callPhone,
  /// Send an SMS (requires confirmation).
  sendSms,
  /// Compose an email (requires confirmation).
  composeEmail,
  /// Save a contact to the address book (requires confirmation).
  saveContact,
  /// Add a calendar event (requires confirmation).
  addCalendarEvent,
  /// Open coordinates in a map app (requires confirmation).
  openInMap,
  /// Look up a product barcode online (requires confirmation).
  lookupProduct,
  /// Re-scan another code.
  rescan,
}

extension SuggestedActionTypeX on SuggestedActionType {
  String get label {
    switch (this) {
      case SuggestedActionType.openUrl:
        return 'Open link';
      case SuggestedActionType.copy:
        return 'Copy';
      case SuggestedActionType.share:
        return 'Share';
      case SuggestedActionType.saveFavourite:
        return 'Save to favourites';
      case SuggestedActionType.addNote:
        return 'Add note';
      case SuggestedActionType.dismiss:
        return 'Dismiss';
      case SuggestedActionType.joinWifi:
        return 'Join Wi-Fi';
      case SuggestedActionType.callPhone:
        return 'Call number';
      case SuggestedActionType.sendSms:
        return 'Send SMS';
      case SuggestedActionType.composeEmail:
        return 'Compose email';
      case SuggestedActionType.saveContact:
        return 'Save contact';
      case SuggestedActionType.addCalendarEvent:
        return 'Add to calendar';
      case SuggestedActionType.openInMap:
        return 'Open in map';
      case SuggestedActionType.lookupProduct:
        return 'Look up product';
      case SuggestedActionType.rescan:
        return 'Scan another';
    }
  }

  IconData get icon {
    switch (this) {
      case SuggestedActionType.openUrl:
        return Icons.open_in_browser;
      case SuggestedActionType.copy:
        return Icons.copy;
      case SuggestedActionType.share:
        return Icons.share;
      case SuggestedActionType.saveFavourite:
        return Icons.star_outline;
      case SuggestedActionType.addNote:
        return Icons.note_add;
      case SuggestedActionType.dismiss:
        return Icons.close;
      case SuggestedActionType.joinWifi:
        return Icons.wifi;
      case SuggestedActionType.callPhone:
        return Icons.phone;
      case SuggestedActionType.sendSms:
        return Icons.sms;
      case SuggestedActionType.composeEmail:
        return Icons.email;
      case SuggestedActionType.saveContact:
        return Icons.contact_page;
      case SuggestedActionType.addCalendarEvent:
        return Icons.event;
      case SuggestedActionType.openInMap:
        return Icons.map;
      case SuggestedActionType.lookupProduct:
        return Icons.search;
      case SuggestedActionType.rescan:
        return Icons.qr_code_scanner;
    }
  }

  /// Whether this action requires explicit user confirmation.
  bool get requiresConfirmation {
    switch (this) {
      case SuggestedActionType.copy:
      case SuggestedActionType.share:
      case SuggestedActionType.saveFavourite:
      case SuggestedActionType.addNote:
      case SuggestedActionType.dismiss:
      case SuggestedActionType.rescan:
        return false;
      default:
        return true;
    }
  }
}

@freezed
class SuggestedAction with _$SuggestedAction {
  const factory SuggestedAction({
    required SuggestedActionType type,
    /// The label to display on the action button.
    required String label,
    /// The value that will be used when the action is performed
    /// (e.g. the URL to open, the phone number to call).
    String? actionValue,
    /// Whether this action is the primary recommended action.
    @Default(false) bool isPrimary,
  }) = _SuggestedAction;

  factory SuggestedAction.fromJson(Map<String, dynamic> json) =>
      _$SuggestedActionFromJson(json);
}
