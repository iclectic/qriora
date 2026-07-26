import '../../scanner/domain/scan_payload.dart';
import '../../scanner/domain/scan_content_type.dart';
import 'risk_finding.dart';
import 'risk_severity.dart';
import 'analysis_result.dart';
import 'analysis_method.dart';
import 'analysis_version.dart';
import 'extracted_entity.dart';

/// Deterministic risk analysis engine.
///
/// Applies a set of local, deterministic rules to a scanned payload
/// and produces an [AnalysisResult] with [RiskFinding]s.
///
/// IMPORTANT: This engine never claims content is "completely safe".
/// The absence of findings means only that no known risk indicator
/// was detected — not that the content is safe.
class RiskAnalyser {
  final AnalysisVersion _engineVersion;

  RiskAnalyser({AnalysisVersion? engineVersion})
      : _engineVersion = engineVersion ?? const AnalysisVersion();

  /// Analyses a [ScanPayload] and returns an [AnalysisResult].
  AnalysisResult analyse(ScanPayload payload) {
    final findings = <RiskFinding>[];
    final version = _engineVersion.versionString;

    switch (payload.contentType) {
      case ScanContentType.httpsUrl:
        findings.addAll(_analyseHttpsUrl(payload, version));
        break;
      case ScanContentType.httpUrl:
        findings.addAll(_analyseHttpUrl(payload, version));
        break;
      case ScanContentType.email:
      case ScanContentType.mailto:
        findings.addAll(_analyseEmail(payload, version));
        break;
      case ScanContentType.phoneNumber:
      case ScanContentType.tel:
        findings.addAll(_analysePhone(payload, version));
        break;
      case ScanContentType.sms:
        findings.addAll(_analyseSms(payload, version));
        break;
      case ScanContentType.wifi:
        findings.addAll(_analyseWifi(payload, version));
        break;
      case ScanContentType.vCard:
      case ScanContentType.meCard:
        findings.addAll(_analyseContact(payload, version));
        break;
      case ScanContentType.calendarEvent:
        findings.addAll(_analyseCalendarEvent(payload, version));
        break;
      case ScanContentType.geoCoordinates:
      case ScanContentType.mapLink:
        findings.addAll(_analyseGeo(payload, version));
        break;
      case ScanContentType.deepLink:
        findings.addAll(_analyseDeepLink(payload, version));
        break;
      case ScanContentType.productBarcode:
      case ScanContentType.gs1Data:
        findings.addAll(_analyseProductBarcode(payload, version));
        break;
      case ScanContentType.plainText:
        findings.addAll(_analysePlainText(payload, version));
        break;
      case ScanContentType.unknown:
        findings.add(RiskFinding(
          ruleId: 'unknown-content',
          severity: RiskSeverity.unableToDetermine,
          title: 'Unrecognised content',
          explanation: 'Qriora could not identify what type of content this code contains. '
              'The analysis is limited because the content type is unknown.',
          evidence: payload.rawValue.length > 100
              ? '${payload.rawValue.substring(0, 100)}...'
              : payload.rawValue,
          recommendedResponse: 'Treat this content with caution. Do not proceed unless you '
              'understand what it contains.',
          analysisMethod: AnalysisMethod.deterministicRule,
          ruleVersion: version,
        ));
        break;
      case ScanContentType.malformed:
        findings.add(RiskFinding(
          ruleId: 'malformed-content',
          severity: RiskSeverity.caution,
          title: 'Malformed content',
          explanation: 'This code appears to contain a known format but could not be fully parsed. '
              'Some fields may be missing or corrupted.',
          evidence: payload.rawValue.length > 100
              ? '${payload.rawValue.substring(0, 100)}...'
              : payload.rawValue,
          recommendedResponse: 'Review the raw content carefully before proceeding. '
              'The structured preview may be incomplete.',
          analysisMethod: AnalysisMethod.deterministicRule,
          ruleVersion: version,
        ));
        break;
    }

    // Cross-cutting rules
    findings.addAll(_checkUrlShorteners(payload, version));
    findings.addAll(_checkSuspiciousKeywords(payload, version));
    findings.addAll(_checkEmbeddedCredentials(payload, version));

    // Sort findings by severity (highest first)
    findings.sort((a, b) => b.severity.sortOrder.compareTo(a.severity.sortOrder));

    final overallSeverity = _determineOverallSeverity(findings);
    final summary = _buildSummary(payload, findings, overallSeverity);
    final limitations = _buildLimitations(payload);

    return AnalysisResult(
      overallSeverity: overallSeverity,
      findings: findings,
      summary: summary,
      limitations: limitations,
      analysisVersion: version,
      analysisMethod: AnalysisMethod.deterministicRule,
      usedNetworkLookup: false,
    );
  }

  RiskSeverity _determineOverallSeverity(List<RiskFinding> findings) {
    if (findings.isEmpty) return RiskSeverity.informational;
    return findings.map((f) => f.severity).reduce((a, b) =>
        a.sortOrder >= b.sortOrder ? a : b);
  }

  String _buildSummary(ScanPayload payload, List<RiskFinding> findings, RiskSeverity severity) {
    final typeLabel = payload.contentType.label;
    if (findings.isEmpty) {
      return 'This code contains $typeLabel. No known risk indicators were detected '
          'by the local analysis rules. This does not mean the content is completely safe.';
    }
    return 'This code contains $typeLabel. ${severity.explanation}';
  }

  List<String> _buildLimitations(ScanPayload payload) {
    return [
      'This analysis is performed entirely on-device using deterministic rules.',
      'No network-based reputation lookup was performed.',
      'The absence of warnings does not guarantee safety.',
      if (payload.contentType == ScanContentType.deepLink)
        'Deep links may open third-party applications whose behaviour cannot be predicted.',
      if (payload.contentType == ScanContentType.wifi)
        'Wi-Fi credentials cannot be verified for security. The network may be malicious.',
    ];
  }

  // --- Content-type-specific rules ---

  List<RiskFinding> _analyseHttpsUrl(ScanPayload payload, String version) {
    final findings = <RiskFinding>[];
    final domain = _getDomain(payload);

    // Check for IP address as host
    if (domain != null && _isIpAddress(domain)) {
      findings.add(RiskFinding(
        ruleId: 'url-ip-host',
        severity: RiskSeverity.caution,
        title: 'Link uses an IP address',
        explanation: 'This URL points directly to an IP address instead of a domain name. '
            'IP addresses are sometimes used in phishing because they bypass domain-based '
            'security checks.',
        evidence: domain,
        recommendedResponse: 'Verify that you trust this IP address before opening the link.',
        analysisMethod: AnalysisMethod.deterministicRule,
        ruleVersion: version,
      ));
    }

    // Check for excessive subdomains
    if (domain != null && domain.split('.').length > 5) {
      findings.add(RiskFinding(
        ruleId: 'url-excessive-subdomains',
        severity: RiskSeverity.caution,
        title: 'Link has many subdomain levels',
        explanation: 'This URL has an unusually high number of subdomain levels, which '
            'can be used to disguise the real destination domain.',
        evidence: domain,
        recommendedResponse: 'Check the main domain carefully. The last two parts of '
            'the domain are the most important.',
        analysisMethod: AnalysisMethod.deterministicRule,
        ruleVersion: version,
      ));
    }

    // Check for non-standard port
    try {
      final uri = Uri.parse(payload.normalisedValue);
      if (uri.hasPort && uri.port != 443 && uri.port != 80) {
        findings.add(RiskFinding(
          ruleId: 'url-non-standard-port',
          severity: RiskSeverity.caution,
          title: 'Link uses a non-standard port',
          explanation: 'This URL uses a port number other than the standard 443 for HTTPS. '
              'Non-standard ports can indicate an unconventional server setup.',
          evidence: 'Port ${uri.port}',
          recommendedResponse: 'Verify the destination before opening.',
          analysisMethod: AnalysisMethod.deterministicRule,
          ruleVersion: version,
        ));
      }
    } catch (_) {}

    return findings;
  }

  List<RiskFinding> _analyseHttpUrl(ScanPayload payload, String version) {
    final findings = <RiskFinding>[];

    findings.add(RiskFinding(
      ruleId: 'http-insecure',
      severity: RiskSeverity.caution,
      title: 'Unencrypted HTTP link',
      explanation: 'This URL uses HTTP, which means data sent to and from this website '
          'is not encrypted. Anyone on the same network could potentially observe or '
          'modify the traffic.',
      evidence: payload.normalisedValue,
      recommendedResponse: 'If the website supports HTTPS (https://), prefer that instead. '
          'Do not enter sensitive information on HTTP pages.',
      analysisMethod: AnalysisMethod.deterministicRule,
      ruleVersion: version,
    ));

    // Also run the HTTPS checks
    findings.addAll(_analyseHttpsUrl(payload, version));

    return findings;
  }

  List<RiskFinding> _analyseEmail(ScanPayload payload, String version) {
    return [];
  }

  List<RiskFinding> _analysePhone(ScanPayload payload, String version) {
    return [];
  }

  List<RiskFinding> _analyseSms(ScanPayload payload, String version) {
    final findings = <RiskFinding>[];
    // Check for premium-rate number prefixes
    final phoneEntity = payload.entities
        .where((e) => e.type == ExtractedEntityType.phoneNumber)
        .firstOrNull;
    if (phoneEntity != null) {
      final digits = phoneEntity.value.replaceAll(RegExp(r'[^\d]'), '');
      if (digits.startsWith('0900') || digits.startsWith('0901') || digits.startsWith('0939')) {
        findings.add(RiskFinding(
          ruleId: 'sms-premium-number',
          severity: RiskSeverity.highRisk,
          title: 'Premium-rate phone number',
          explanation: 'The phone number in this SMS payload appears to be a premium-rate '
              'number. Sending a message to this number may incur significant charges.',
          evidence: phoneEntity.value,
          recommendedResponse: 'Do not send the message unless you are certain you want to '
              'incur the potential charges.',
          analysisMethod: AnalysisMethod.deterministicRule,
          ruleVersion: version,
        ));
      }
    }
    return findings;
  }

  List<RiskFinding> _analyseWifi(ScanPayload payload, String version) {
    final findings = <RiskFinding>[];

    findings.add(RiskFinding(
      ruleId: 'wifi-credentials-embedded',
      severity: RiskSeverity.caution,
      title: 'Wi-Fi network credentials',
      explanation: 'This code contains Wi-Fi network credentials. Joining the network will '
          'connect your device to an access point you have not verified. The network operator '
          'can observe your traffic unless you use a VPN.',
      evidence: _getEntityValue(payload, ExtractedEntityType.ssid) ?? 'Wi-Fi payload',
      recommendedResponse: 'Only join this network if you trust the source. Consider using a '
          'VPN for additional privacy.',
      analysisMethod: AnalysisMethod.deterministicRule,
      ruleVersion: version,
    ));

    // Check for open/unencrypted network
    final encryption = _getEntityValue(payload, ExtractedEntityType.encryptionType);
    if (encryption != null && encryption.toUpperCase() == 'NOPASS') {
      findings.add(RiskFinding(
        ruleId: 'wifi-open-network',
        severity: RiskSeverity.caution,
        title: 'Open (unencrypted) Wi-Fi network',
        explanation: 'This Wi-Fi network has no encryption. Traffic sent over this network '
            'can be observed by anyone in range.',
        evidence: 'Encryption: $encryption',
        recommendedResponse: 'Avoid sending sensitive data over this network. Use a VPN if '
            'you must connect.',
        analysisMethod: AnalysisMethod.deterministicRule,
        ruleVersion: version,
      ));
    }

    return findings;
  }

  List<RiskFinding> _analyseContact(ScanPayload payload, String version) {
    return [];
  }

  List<RiskFinding> _analyseCalendarEvent(ScanPayload payload, String version) {
    return [];
  }

  List<RiskFinding> _analyseGeo(ScanPayload payload, String version) {
    return [];
  }

  List<RiskFinding> _analyseDeepLink(ScanPayload payload, String version) {
    final findings = <RiskFinding>[];

    findings.add(RiskFinding(
      ruleId: 'deep-link-unknown-app',
      severity: RiskSeverity.caution,
      title: 'App deep link',
      explanation: 'This code contains a deep link that may open a specific application on '
          'your device. Qriora cannot determine what the application will do.',
      evidence: payload.normalisedValue,
      recommendedResponse: 'Only open this link if you recognise the application and trust '
          'the source.',
      analysisMethod: AnalysisMethod.deterministicRule,
      ruleVersion: version,
    ));

    return findings;
  }

  List<RiskFinding> _analyseProductBarcode(ScanPayload payload, String version) {
    return [];
  }

  List<RiskFinding> _analysePlainText(ScanPayload payload, String version) {
    return [];
  }

  // --- Cross-cutting rules ---

  List<RiskFinding> _checkUrlShorteners(ScanPayload payload, String version) {
    final findings = <RiskFinding>[];
    if (!_isUrlType(payload.contentType)) return findings;

    final domain = _getDomain(payload);
    if (domain == null) return findings;

    const shorteners = {
      'bit.ly', 'tinyurl.com', 't.co', 'goo.gl', 'ow.ly', 'is.gd',
      'buff.ly', 'rebrand.ly', 'cutt.ly', 'shorturl.at', 'tiny.cc',
    };

    final lowerDomain = domain.toLowerCase();
    for (final shortener in shorteners) {
      if (lowerDomain == shortener || lowerDomain.endsWith('.$shortener')) {
        findings.add(RiskFinding(
          ruleId: 'url-shortener',
          severity: RiskSeverity.caution,
          title: 'Shortened URL',
          explanation: 'This URL has been shortened, which hides the real destination. '
              'Shortened links are sometimes used to redirect users to unexpected or '
              'malicious websites.',
          evidence: domain,
          recommendedResponse: 'Before opening, consider using a link preview service or '
              'expanding the URL to see the real destination.',
          analysisMethod: AnalysisMethod.deterministicRule,
          ruleVersion: version,
        ));
        break;
      }
    }

    return findings;
  }

  List<RiskFinding> _checkSuspiciousKeywords(ScanPayload payload, String version) {
    final findings = <RiskFinding>[];
    if (!_isUrlType(payload.contentType)) return findings;

    final lower = payload.normalisedValue.toLowerCase();
    const suspiciousKeywords = [
      'login', 'signin', 'account', 'verify', 'secure', 'update',
      'confirm', 'password', 'banking', 'wallet', 'crypto',
    ];

    final matchedKeywords = suspiciousKeywords
        .where((k) => lower.contains(k))
        .toList();

    if (matchedKeywords.isNotEmpty) {
      findings.add(RiskFinding(
        ruleId: 'url-sensitive-keywords',
        severity: RiskSeverity.caution,
        title: 'Link contains sensitive keywords',
        explanation: 'This URL contains keywords commonly associated with phishing attempts: '
            '${matchedKeywords.join(', ')}. While these words can appear in legitimate URLs, '
            'they are also frequently used to trick users into entering credentials.',
        evidence: matchedKeywords.join(', '),
        recommendedResponse: 'Verify the domain carefully before proceeding. Legitimate '
            'services typically use their own well-known domains.',
        analysisMethod: AnalysisMethod.heuristic,
        ruleVersion: version,
      ));
    }

    return findings;
  }

  List<RiskFinding> _checkEmbeddedCredentials(ScanPayload payload, String version) {
    final findings = <RiskFinding>[];
    if (!_isUrlType(payload.contentType)) return findings;

    try {
      final uri = Uri.parse(payload.normalisedValue);
      if (uri.userInfo.isNotEmpty) {
        findings.add(RiskFinding(
          ruleId: 'url-embedded-credentials',
          severity: RiskSeverity.highRisk,
          title: 'URL contains embedded credentials',
          explanation: 'This URL contains a username and/or password embedded in the address. '
              'This technique is sometimes used in phishing to disguise the real destination '
              'or to capture credentials.',
          evidence: 'Credentials present in URL',
          recommendedResponse: 'Do not open this link. Embedded credentials in URLs are a '
              'known phishing technique.',
          analysisMethod: AnalysisMethod.deterministicRule,
          ruleVersion: version,
        ));
      }
    } catch (_) {}

    return findings;
  }

  // --- Helpers ---

  bool _isUrlType(ScanContentType type) {
    return type == ScanContentType.httpsUrl ||
        type == ScanContentType.httpUrl ||
        type == ScanContentType.mapLink;
  }

  String? _getDomain(ScanPayload payload) {
    final domainEntity = payload.entities
        .where((e) => e.type == ExtractedEntityType.domain)
        .firstOrNull;
    return domainEntity?.value;
  }

  String? _getEntityValue(ScanPayload payload, ExtractedEntityType type) {
    final entity = payload.entities.where((e) => e.type == type).firstOrNull;
    return entity?.value;
  }

  bool _isIpAddress(String host) {
    return RegExp(r'^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$').hasMatch(host) ||
        host.contains(':'); // IPv6
  }
}
