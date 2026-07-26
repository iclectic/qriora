/// Represents the source from which a scan was obtained.
enum ScanSource {
  camera,
  imageFile,
  manualEntry,
  imported,
}

extension ScanSourceX on ScanSource {
  String get label {
    switch (this) {
      case ScanSource.camera:
        return 'Camera';
      case ScanSource.imageFile:
        return 'Image file';
      case ScanSource.manualEntry:
        return 'Manual entry';
      case ScanSource.imported:
        return 'Imported';
    }
  }
}
