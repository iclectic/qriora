/// Approved deep-link schemes that Qriora will offer to open.
///
/// Schemes not on this list will still be classified as deep links
/// and displayed to the user, but the "Open" action will be suppressed
/// and a warning will be shown instead.
class DeepLinkAllowlist {
  DeepLinkAllowlist._();

  /// Schemes that are considered safe to offer for opening.
  static const approvedSchemes = {
    'mailto',
    'tel',
    'sms',
    'smsto',
    'geo',
    'maps',
    'https',
    'http',
  };

  /// App-specific deep-link schemes that are commonly used and recognised.
  /// These are platform-agnostic scheme prefixes; the actual app
  /// availability is checked at runtime by the platform.
  static const approvedAppSchemes = {
    'whatsapp',
    'tg',
    'snapchat',
    'instagram',
    'fb',
    'twitter',
    'youtube',
    'spotify',
    'zoomus',
  };

  /// Returns true if the given scheme is approved for opening.
  static bool isApproved(String scheme) {
    final lower = scheme.toLowerCase();
    return approvedSchemes.contains(lower) ||
        approvedAppSchemes.contains(lower);
  }

  /// Returns true if the given URI is an approved deep link.
  static bool isApprovedUri(Uri uri) {
    return isApproved(uri.scheme);
  }
}
