import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'suggested_action.dart';
import '../../scanner/domain/scan_payload.dart';
import '../../scanner/domain/scan_record.dart';
import 'extracted_entity.dart';
import 'deep_link_allowlist.dart';

/// Result of an action execution attempt.
sealed class ActionResult {
  const ActionResult();
}

/// Action executed successfully.
class ActionSuccess extends ActionResult {
  final String message;
  const ActionSuccess(this.message);
}

/// Action was cancelled by the user.
class ActionCancelled extends ActionResult {
  const ActionCancelled();
}

/// Action could not be performed (platform limitation, invalid data, etc.).
class ActionFailure extends ActionResult {
  final String reason;
  const ActionFailure(this.reason);
}

/// Platform-aware action executor.
///
/// This service keeps all platform interactions (URL launching, sharing,
/// clipboard) behind a single interface so that business logic in widgets
/// remains thin and testable.
class ActionExecutor {
  /// Executes a copy action.
  Future<ActionResult> copy(String value) async {
    try {
      await Clipboard.setData(ClipboardData(text: value));
      return const ActionSuccess('Copied to clipboard');
    } catch (e) {
      return ActionFailure('Could not copy: $e');
    }
  }

  /// Executes a share action.
  Future<ActionResult> share(String value) async {
    try {
      await Share.share(value);
      return const ActionSuccess('Shared');
    } catch (e) {
      return ActionFailure('Could not share: $e');
    }
  }

  /// Opens a URL in the external browser.
  ///
  /// Returns [ActionFailure] if the URL scheme is not approved
  /// or if the platform cannot launch it.
  Future<ActionResult> openUrl(String url) async {
    final uri = Uri.parse(url);

    if (uri.scheme == 'http' || uri.scheme == 'https') {
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (launched) return const ActionSuccess('Link opened');
      return const ActionFailure('Could not open link');
    }

    if (DeepLinkAllowlist.isApprovedUri(uri)) {
      final launched = await launchUrl(uri);
      if (launched) return const ActionSuccess('Opened');
      return const ActionFailure('Could not open link');
    }

    return ActionFailure(
      'The scheme "${uri.scheme}://" is not in Qriora\'s approved list. '
      'This link will not be opened automatically.',
    );
  }

  /// Dials a phone number.
  Future<ActionResult> callPhone(String number) async {
    final uri = Uri.parse('tel:$number');
    final launched = await launchUrl(uri);
    if (launched) return const ActionSuccess('Calling');
    return const ActionFailure('Could not initiate call');
  }

  /// Opens SMS composer.
  Future<ActionResult> sendSms(String number, {String? body}) async {
    final uri = body != null && body.isNotEmpty
        ? Uri.parse('sms:$number?body=${Uri.encodeComponent(body)}')
        : Uri.parse('sms:$number');
    final launched = await launchUrl(uri);
    if (launched) return const ActionSuccess('SMS composer opened');
    return const ActionFailure('Could not open SMS composer');
  }

  /// Opens email composer.
  Future<ActionResult> composeEmail(String email, {String? subject, String? body}) async {
    final params = <String, String>{};
    if (subject != null) params['subject'] = subject;
    if (body != null) params['body'] = body;
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: params.isNotEmpty ? params : null,
    );
    final launched = await launchUrl(uri);
    if (launched) return const ActionSuccess('Email composer opened');
    return const ActionFailure('Could not open email composer');
  }

  /// Opens a location in the default map app.
  Future<ActionResult> openInMap(String value) async {
    final uri = Uri.parse(value);
    final launched = await launchUrl(uri);
    if (launched) return const ActionSuccess('Map opened');
    return const ActionFailure('Could not open map');
  }

  /// Looks up a product barcode online.
  Future<ActionResult> lookupProduct(String barcode) async {
    final url = 'https://www.google.com/search?q=${Uri.encodeComponent(barcode)}';
    return openUrl(url);
  }

  /// Builds a human-readable confirmation message for a sensitive action.
  ///
  /// This shows the user exactly what will happen before they confirm.
  static String buildConfirmationMessage(SuggestedAction action, ScanRecord record) {
    final payload = record.payload;

    switch (action.type) {
      case SuggestedActionType.openUrl:
        final uri = Uri.parse(action.actionValue ?? '');
        final host = uri.host.isNotEmpty ? uri.host : action.actionValue ?? '';
        return 'This will open a website at:\n\n$host\n\n'
            'Full address: ${action.actionValue}';

      case SuggestedActionType.callPhone:
        final phone = _getEntityValue(payload, ExtractedEntityType.phoneNumber) ??
            action.actionValue ?? '';
        return 'This will dial the following number:\n\n$phone';

      case SuggestedActionType.sendSms:
        final phone = _getEntityValue(payload, ExtractedEntityType.phoneNumber) ??
            action.actionValue ?? '';
        final body = _getEntityValue(payload, ExtractedEntityType.body);
        final buffer = StringBuffer('This will open your SMS app to send a message to:\n\n$phone');
        if (body != null && body.isNotEmpty) {
          buffer.write('\n\nMessage content:\n\n$body');
        }
        return buffer.toString();

      case SuggestedActionType.composeEmail:
        final email = _getEntityValue(payload, ExtractedEntityType.emailAddress) ??
            action.actionValue ?? '';
        final subject = _getEntityValue(payload, ExtractedEntityType.subject);
        final body = _getEntityValue(payload, ExtractedEntityType.body);
        final buffer = StringBuffer('This will open your email app to compose a message to:\n\n$email');
        if (subject != null && subject.isNotEmpty) {
          buffer.write('\n\nSubject: $subject');
        }
        if (body != null && body.isNotEmpty) {
          buffer.write('\n\nBody: $body');
        }
        return buffer.toString();

      case SuggestedActionType.joinWifi:
        final ssid = _getEntityValue(payload, ExtractedEntityType.ssid) ?? 'Unknown network';
        final encryption = _getEntityValue(payload, ExtractedEntityType.encryptionType) ?? 'Unknown';
        return 'This will attempt to join a Wi-Fi network:\n\n'
            'Network name: $ssid\n'
            'Security: $encryption\n\n'
            'Joining this network will connect your device to an access point '
            'you have not verified.';

      case SuggestedActionType.saveContact:
        final name = _getEntityValue(payload, ExtractedEntityType.contactName) ?? 'Unknown';
        final org = _getEntityValue(payload, ExtractedEntityType.organisation);
        final buffer = StringBuffer('This will save a contact to your device:\n\nName: $name');
        if (org != null && org.isNotEmpty) buffer.write('\nOrganisation: $org');
        return buffer.toString();

      case SuggestedActionType.addCalendarEvent:
        final title = _getEntityValue(payload, ExtractedEntityType.eventTitle) ?? 'Untitled event';
        final start = _getEntityValue(payload, ExtractedEntityType.eventStart);
        final end = _getEntityValue(payload, ExtractedEntityType.eventEnd);
        final location = _getEntityValue(payload, ExtractedEntityType.eventLocation);
        final buffer = StringBuffer('This will add an event to your calendar:\n\nTitle: $title');
        if (start != null) buffer.write('\nStart: $start');
        if (end != null) buffer.write('\nEnd: $end');
        if (location != null && location.isNotEmpty) buffer.write('\nLocation: $location');
        return buffer.toString();

      case SuggestedActionType.openInMap:
        final lat = _getEntityValue(payload, ExtractedEntityType.latitude);
        final lng = _getEntityValue(payload, ExtractedEntityType.longitude);
        if (lat != null && lng != null) {
          return 'This will open a map at coordinates:\n\nLatitude: $lat\nLongitude: $lng';
        }
        return 'This will open a map for:\n\n${action.actionValue}';

      case SuggestedActionType.lookupProduct:
        return 'This will search the web for product code:\n\n${action.actionValue}';

      case SuggestedActionType.copy:
      case SuggestedActionType.share:
      case SuggestedActionType.saveFavourite:
      case SuggestedActionType.addNote:
      case SuggestedActionType.dismiss:
      case SuggestedActionType.rescan:
        return action.label;
    }
  }

  static String? _getEntityValue(ScanPayload payload, ExtractedEntityType type) {
    final entity = payload.entities.where((e) => e.type == type).firstOrNull;
    return entity?.value;
  }
}
