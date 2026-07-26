/// Normalises a raw scanned value.
///
/// Performs trimming, whitespace normalisation, and scheme
/// lowercasing without altering the semantic content.
class ContentNormaliser {
  /// Normalises a raw scanned value.
  String normalise(String rawValue) {
    var normalised = rawValue.trim();

    // Normalise line endings
    normalised = normalised.replaceAll('\r\n', '\n');
    normalised = normalised.replaceAll('\r', '\n');

    // Collapse multiple spaces (but not newlines — important for vCards)
    normalised = normalised.replaceAll(RegExp(r'[ \t]+'), ' ');

    // Lowercase the URI scheme if present
    final schemeMatch = RegExp(r'^([a-zA-Z][a-zA-Z0-9+.-]*):').firstMatch(normalised);
    if (schemeMatch != null) {
      final scheme = schemeMatch.group(1)!;
      normalised = normalised.substring(0, scheme.length) +
          normalised.substring(scheme.length);
      // Lowercase just the scheme part
      normalised = scheme.toLowerCase() + normalised.substring(scheme.length);
    }

    return normalised;
  }

  /// Masks a sensitive value for display.
  ///
  /// Returns a partially masked string where only the first and last
  /// characters are visible. If the value is too short, returns all dots.
  String mask(String value) {
    if (value.isEmpty) return value;
    if (value.length <= 2) return '••••';
    if (value.length <= 6) return '${value[0]}••••';
    return '${value.substring(0, 2)}••••${value.substring(value.length - 2)}';
  }
}
