# Changelog

All notable changes to Qriora will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased] — Beta 1

### Added

- **On-device risk analysis engine** with deterministic rules for URL, Wi-Fi, contact, calendar, SMS, email, and phone content.
- **Extended safety rules**: punycode/IDN homograph detection, Unicode mixed-script confusables, localhost/private IP detection, WEP encryption warning, calendar/contact URL detection, SMS URL detection.
- **Safe preview** — content type and normalised value shown before any action is taken.
- **Risk explanation screen** with severity-coloured headers, evidence, recommended response, and analysis method details.
- **Report incorrect analysis** — users can submit feedback on false positives, missing risks, incorrect severity, or unclear explanations.
- **Scanner features**:
  - Camera permission flow with lifecycle recovery
  - Torch toggle, camera switch, pause/resume
  - Gallery image scanning
  - Manual text entry
  - Haptic and sound feedback (configurable)
  - Duplicate scan suppression
  - Scanner guidance overlay with tips for low-light and blurred conditions
- **History** with search, filtering by content type, and empty states.
- **Favourites** with note support.
- **Settings**:
  - Theme selection (light/dark/system)
  - High contrast mode
  - Large text mode
  - Reduced motion
  - Private mode
  - Configurable retention policy (7/30/90 days or never)
  - Haptic and sound feedback toggles
  - Sensitive value masking
  - Deduplication toggle
  - Biometric lock
- **Encrypted export** — AES-256 encrypted export with user-provided password.
- **Encrypted import** — import and decrypt scan records from Qriora export files.
- **Delete all data** option with confirmation dialog.
- **Deep-link allowlist** — only known, safe deep-link schemes are allowed.
- **Pre-action confirmation dialogs** for opening URLs, joining Wi-Fi, dialling numbers, etc.
- **Platform-aware actions** — actions are adapted for Android vs iOS.
- **Screenshot protection** — blocks screenshots on sensitive screens (Android `FLAG_SECURE`).
- **Accessibility**:
  - Semantic labels on all interactive elements
  - Logical focus traversal order
  - Live region announcements for processing states
  - Severity communicated via icons + labels + text, not colour alone
  - High-contrast and large text settings
  - Reduced motion setting
- **Low-storage monitoring** with warning banner.
- **Privacy-safe logging** — logger never logs raw scan values or parsed entities.
- **Error handling** — global error widget and Riverpod-based error boundaries.
- **Environment configurations** (dev/staging/prod).
- **Onboarding** with three-step introduction for new users.
- **GitHub Actions CI** — formatting, static analysis, and tests on every push/PR.

### Security

- All analysis performed on-device — no network calls by default.
- Sensitive settings stored in platform secure storage (Keystore/Keychain).
- Export files encrypted with AES-256.
- Screenshot protection on sensitive screens.
- Biometric lock option.

### Known Limitations

- No URL reputation lookup (cannot detect phishing sites).
- No Wi-Fi network safety verification.
- Screenshot protection not available on iOS (platform limitation).
- Low-storage detection is limited on some platforms.
