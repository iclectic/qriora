import 'package:flutter_test/flutter_test.dart';
import 'package:qriora/features/analysis/domain/deep_link_allowlist.dart';

void main() {
  group('DeepLinkAllowlist', () {
    test('approves standard schemes', () {
      expect(DeepLinkAllowlist.isApproved('https'), isTrue);
      expect(DeepLinkAllowlist.isApproved('http'), isTrue);
      expect(DeepLinkAllowlist.isApproved('mailto'), isTrue);
      expect(DeepLinkAllowlist.isApproved('tel'), isTrue);
      expect(DeepLinkAllowlist.isApproved('sms'), isTrue);
      expect(DeepLinkAllowlist.isApproved('geo'), isTrue);
    });

    test('approves known app schemes', () {
      expect(DeepLinkAllowlist.isApproved('whatsapp'), isTrue);
      expect(DeepLinkAllowlist.isApproved('tg'), isTrue);
      expect(DeepLinkAllowlist.isApproved('spotify'), isTrue);
    });

    test('rejects unknown schemes', () {
      expect(DeepLinkAllowlist.isApproved('javascript'), isFalse);
      expect(DeepLinkAllowlist.isApproved('data'), isFalse);
      expect(DeepLinkAllowlist.isApproved('file'), isFalse);
      expect(DeepLinkAllowlist.isApproved('intent'), isFalse);
      expect(DeepLinkAllowlist.isApproved(''), isFalse);
    });

    test('is case-insensitive', () {
      expect(DeepLinkAllowlist.isApproved('HTTPS'), isTrue);
      expect(DeepLinkAllowlist.isApproved('MailTo'), isTrue);
    });

    test('isApprovedUri parses and checks scheme', () {
      expect(DeepLinkAllowlist.isApprovedUri(Uri.parse('https://example.com')), isTrue);
      expect(DeepLinkAllowlist.isApprovedUri(Uri.parse('mailto:test@example.com')), isTrue);
      expect(DeepLinkAllowlist.isApprovedUri(Uri.parse('javascript:alert(1)')), isFalse);
    });
  });
}
