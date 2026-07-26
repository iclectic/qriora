/// Represents the barcode format detected by the scanner.
///
/// Mirrors the formats reported by `mobile_scanner` but kept as an
/// independent enum so the domain layer does not depend on the
/// platform package.
enum BarcodeFormat {
  unknown,
  aztec,
  codabar,
  code39,
  code93,
  code128,
  dataMatrix,
  ean8,
  ean13,
  itf,
  maxiCode,
  pdf417,
  qrCode,
  rss14,
  rssExpanded,
  upcA,
  upcE,
  linear,
  matrix,
}

extension BarcodeFormatX on BarcodeFormat {
  String get label {
    switch (this) {
      case BarcodeFormat.unknown:
        return 'Unknown';
      case BarcodeFormat.aztec:
        return 'Aztec';
      case BarcodeFormat.codabar:
        return 'Codabar';
      case BarcodeFormat.code39:
        return 'Code 39';
      case BarcodeFormat.code93:
        return 'Code 93';
      case BarcodeFormat.code128:
        return 'Code 128';
      case BarcodeFormat.dataMatrix:
        return 'Data Matrix';
      case BarcodeFormat.ean8:
        return 'EAN-8';
      case BarcodeFormat.ean13:
        return 'EAN-13';
      case BarcodeFormat.itf:
        return 'ITF';
      case BarcodeFormat.maxiCode:
        return 'MaxiCode';
      case BarcodeFormat.pdf417:
        return 'PDF417';
      case BarcodeFormat.qrCode:
        return 'QR Code';
      case BarcodeFormat.rss14:
        return 'RSS-14';
      case BarcodeFormat.rssExpanded:
        return 'RSS Expanded';
      case BarcodeFormat.upcA:
        return 'UPC-A';
      case BarcodeFormat.upcE:
        return 'UPC-E';
      case BarcodeFormat.linear:
        return 'Linear';
      case BarcodeFormat.matrix:
        return 'Matrix';
    }
  }

  /// Whether this format is typically used for product barcodes.
  bool get isProductBarcode {
    switch (this) {
      case BarcodeFormat.ean8:
      case BarcodeFormat.ean13:
      case BarcodeFormat.upcA:
      case BarcodeFormat.upcE:
      case BarcodeFormat.itf:
        return true;
      default:
        return false;
    }
  }
}
