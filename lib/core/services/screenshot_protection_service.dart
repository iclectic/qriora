import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

/// Service for protecting sensitive screens from screenshots and screen recording.
///
/// On Android, uses [FlutterWindowManager] to set FLAG_SECURE on the window.
/// On iOS, screenshot prevention is not directly supported via public APIs;
/// instead, a privacy overlay approach would be needed (not implemented here).
class ScreenshotProtectionService {
  bool _isEnabled = false;

  /// Whether screenshot protection is currently active.
  bool get isEnabled => _isEnabled;

  /// Enables screenshot protection on the current window.
  ///
  /// On Android, this sets FLAG_SECURE which prevents screenshots
  /// and screen recording. On iOS, this is a no-op (returns false).
  Future<bool> enable() async {
    if (Platform.isAndroid) {
      try {
        await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
        _isEnabled = true;
        return true;
      } on PlatformException {
        return false;
      }
    }
    // iOS does not support FLAG_SECURE equivalent via public API
    return false;
  }

  /// Disables screenshot protection on the current window.
  Future<bool> disable() async {
    if (Platform.isAndroid) {
      try {
        await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
        _isEnabled = false;
        return true;
      } on PlatformException {
        return false;
      }
    }
    return false;
  }
}
