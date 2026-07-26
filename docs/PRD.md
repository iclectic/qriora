# Qriora — Product Requirements Document

**Version:** 1.0.0  
**Status:** Phase 0 — Implemented  
**Last updated:** 2026-07-26

---

## 1. Overview

Qriora is a privacy-first, on-device QR-code and barcode scanner for iOS and Android. It analyses scanned content locally, explains what the content is and what it will do, surfaces risk indicators, and lets the user decide whether to proceed — without ever automatically opening a link or performing an action.

**Tagline:** *Know before you open.*

---

## 2. Problem statement

Existing QR-code scanners either:
- **Automatically open links** without warning, exposing users to phishing, malware, and unwanted app launches.
- **Send scanned data to remote servers** for analysis, creating a privacy footprint that contradicts the act of scanning an arbitrary code in public.
- **Provide no explanation** of what a code contains or what will happen if the user acts on it.

Qriora addresses all three gaps.

---

## 3. Target users

| User | Need |
|---|---|
| Privacy-conscious individuals | Scan codes without data leaving the device |
| Security-aware professionals | Understand risk indicators before acting |
| Elderly / non-technical users | Plain-language explanations, no auto-open |
| Enterprise / regulated users | Air-gapped scanning with local-only storage |

---

## 4. Goals & non-goals

### Goals
1. **100% on-device analysis** — no network calls for scanning, parsing, or risk evaluation.
2. **Explainable risk** — every finding includes a human-readable explanation and recommended response.
3. **User-in-the-loop** — Qriora never auto-opens links or performs actions without explicit confirmation.
4. **Local-first storage** — scan history lives in an on-device SQLite database with user-controlled retention.
5. **Accessible** — risk communicated via icons, labels, and text, not colour alone.

### Non-goals (v1)
- Cloud-based URL reputation lookups (planned as opt-in for v2).
- AI/ML-based content classification.
- Scanning payment / EMV codes.
- Cross-device sync.

---

## 5. Supported content types

Qriora classifies and parses the following content types:

| Content type | Example | Actions offered |
|---|---|---|
| HTTPS URL | `https://example.com` | Open link, Copy, Share |
| HTTP URL | `http://example.com` | Open link (with warning), Copy, Share |
| Email address | `user@example.com` | Compose email, Copy |
| Mailto link | `mailto:user@example.com` | Compose email, Copy |
| Phone number | `+1234567890` | Call, Copy |
| Tel link | `tel:+1234567890` | Call, Copy |
| SMS payload | `smsto:number:message` | Send SMS, Copy |
| Wi-Fi credentials | `WIFI:T:WPA;S:SSID;P:pass;;` | Join Wi-Fi (with warning), Copy |
| vCard | `BEGIN:VCARD...END:VCARD` | Save contact, Copy |
| MeCard | `MECARD:N:Name;...;;` | Save contact, Copy |
| Calendar event | `BEGIN:VEVENT...END:VEVENT` | Add to calendar, Copy |
| Geo coordinates | `geo:lat,lon` | Open in map, Copy |
| Map link | `https://maps.apple.com/...` | Open in map, Copy |
| App deep link | `myapp://path` | Open (with warning), Copy |
| Product barcode | EAN-13, UPC-A | Look up product, Copy |
| GS1 data | `(01)00012345678905` | Copy |
| Plain text | `Hello, world!` | Copy, Share |
| Unknown | (unrecognised) | Copy raw value |
| Malformed | (partially parsed) | Copy raw value |

---

## 6. Risk analysis

### Severity levels

| Severity | Meaning | UI treatment |
|---|---|---|
| **Informational** | No known risk indicators detected | Neutral icon, no warning colour |
| **Caution** | One or more indicators warrant attention | Caution icon, explanatory text |
| **High risk** | Strong risk indicator detected | Warning icon, prominent display |
| **Unable to determine** | Content type unknown, analysis limited | Question icon, caution advised |

### Risk rules implemented (v1)

| Rule ID | Severity | Trigger |
|---|---|---|
| `http-insecure` | Caution | URL uses HTTP instead of HTTPS |
| `url-ip-host` | Caution | URL points to an IP address, not a domain |
| `url-excessive-subdomains` | Caution | More than 5 subdomain levels |
| `url-non-standard-port` | Caution | Non-standard port for HTTPS |
| `url-shortener` | Caution | Domain matches known URL shortener |
| `url-sensitive-keywords` | Caution | URL contains phishing-associated keywords |
| `url-embedded-credentials` | High risk | URL contains `user:pass@host` |
| `wifi-credentials-embedded` | Caution | Wi-Fi credentials present in payload |
| `wifi-open-network` | Caution | Open/unencrypted Wi-Fi network |
| `deeplink-unknown-app` | Caution | Deep link targets an unknown app |
| `unknown-content` | Unable to determine | Content type not recognised |
| `malformed-content` | Caution | Known format prefix but incomplete parse |

### Key principle

> The absence of warnings does **not** guarantee safety. Every analysis result includes this disclaimer.

---

## 7. Architecture

### Stack
- **Framework:** Flutter 3.x / Dart 3.x
- **State management:** Riverpod 2.x
- **Navigation:** go_router
- **Local DB:** Drift (SQLite)
- **Secure storage:** flutter_secure_storage (for settings)
- **Models:** Freezed + json_serializable
- **Scanner:** mobile_scanner
- **Biometric lock:** local_auth

### Project structure
```
lib/
  app/              # App shell, router, theme, bootstrap
  core/
    database/       # Drift database, tables, DAOs
    services/       # Riverpod providers, settings notifier
  features/
    scanner/        # domain (models, services) + presentation
    analysis/       # domain (risk, actions) + presentation
    history/        # presentation
    favourites/     # presentation
    settings/       # domain + presentation
    privacy/        # presentation
    export/         # presentation
    onboarding/     # presentation
```

### Analysis pipeline

```
Scan (camera/manual)
  → PayloadClassifier.classify()    → ScanContentType
  → ContentNormaliser.normalise()   → normalised string
  → PayloadParser.parse()           → ScanPayload (with entities)
  → EntityExtractor.extract()       → ExtractedEntity list
  → RiskAnalyser.analyse()          → AnalysisResult (with findings)
  → ActionResolver.resolve()        → SuggestedAction list
  → UI: safe preview + risk display + actions
```

---

## 8. Privacy & data handling

| Aspect | Implementation |
|---|---|
| Network | No network calls for analysis. `allowNetworkLookups` setting exists but defaults to `false`. |
| Storage | SQLite database on device. No cloud sync. |
| Private mode | When enabled, scans are not persisted to the database. |
| Retention | User-configurable: 7/30/90 days, or never expire. Auto-purge on app launch. |
| Sensitive values | Wi-Fi passwords and similar are masked in the UI by default. |
| Biometric lock | Optional app-level lock via `local_auth`. |
| Export | User can export history as JSON. No automatic data sharing. |

---

## 9. Accessibility

- Risk severity communicated via **icons + labels + text**, not colour alone.
- `highContrast` and `largeText` settings.
- `reducedMotion` setting to disable animations.
- All interactive elements have semantic labels.

---

## 10. Testing

| Layer | Coverage |
|---|---|
| Unit tests | 60 tests — PayloadClassifier, ContentNormaliser, PayloadParser, EntityExtractor, RiskAnalyser, ActionResolver |
| Widget tests | 16 tests — OnboardingScreen, PrivacyScreen, AboutScreen, RawContentScreen |
| Lint | `flutter_lints` + 20 custom rules, 0 errors |

---

## 11. Future roadmap

| Phase | Feature |
|---|---|
| v1.1 | Opt-in URL reputation lookup (with clear consent) |
| v1.2 | Batch scan history export to CSV |
| v1.3 | Custom risk rules (user-defined keywords) |
| v2.0 | On-device ML model for phishing detection |
