import 'package:permission_handler/permission_handler.dart' as ph;

/// Camera permission status.
enum CameraPermissionStatus {
  granted,
  denied,
  permanentlyDenied,
  restricted,
}

/// Service for managing camera permissions.
///
/// Kept behind an interface so it can be mocked in tests.
class PermissionService {
  /// Requests camera permission and returns the result.
  Future<CameraPermissionStatus> requestCameraPermission() async {
    final status = await ph.Permission.camera.request();
    return _mapStatus(status);
  }

  /// Checks the current camera permission status without requesting.
  Future<CameraPermissionStatus> checkCameraPermission() async {
    final status = await ph.Permission.camera.status;
    return _mapStatus(status);
  }

  /// Opens the app settings page (for permanently-denied state).
  Future<void> openAppSettings() async {
    await ph.openAppSettings();
  }

  CameraPermissionStatus _mapStatus(ph.PermissionStatus status) {
    switch (status) {
      case ph.PermissionStatus.granted:
        return CameraPermissionStatus.granted;
      case ph.PermissionStatus.denied:
        return CameraPermissionStatus.denied;
      case ph.PermissionStatus.permanentlyDenied:
        return CameraPermissionStatus.permanentlyDenied;
      case ph.PermissionStatus.restricted:
        return CameraPermissionStatus.restricted;
      case ph.PermissionStatus.limited:
        return CameraPermissionStatus.granted;
      case ph.PermissionStatus.provisional:
        return CameraPermissionStatus.granted;
    }
  }
}
