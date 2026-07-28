# Qriora

**Privacy-first intelligent QR-code and barcode scanner.**

Know before you open.

---

## What Qriora does

Qriora scans QR codes and barcodes, explains what the content is, identifies locally detectable risks, and requires explicit confirmation before performing any external action (opening a link, joining Wi-Fi, dialling a number, etc.).

## Why it is different

- **100% on-device analysis** — no scanned content is sent to any server.
- **Explainable risk** — every finding has a human-readable explanation and recommended response.
- **User-in-the-loop** — Qriora never automatically opens links or performs actions.
- **No "safe" label** — the absence of warnings does not mean content is safe.
- **Private mode** — scans can be performed without leaving any trace on the device.

## How privacy works

| Aspect | Implementation |
|---|---|
| Network | No network calls for analysis. All parsing and risk evaluation is local. |
| Storage | SQLite database on device. No cloud sync. |
| Private mode | Scans are not persisted to the database. |
| Retention | User-configurable: 7/30/90 days, or keep until manually deleted. |
| Sensitive values | Wi-Fi passwords and similar are masked in the UI by default. |
| Logging | The logger never logs raw scan values or parsed entities. |

## What the safety engine can and cannot determine

**Can detect:**
- HTTP instead of HTTPS
- IP-address destinations
- URL shorteners
- Embedded credentials in URLs
- Excessive subdomains
- Non-standard ports
- Suspicious keywords
- Open/unencrypted Wi-Fi
- Deep links to unknown apps
- Premium-rate SMS numbers

**Cannot determine:**
- Whether a URL points to a phishing site (no reputation lookup)
- Whether a Wi-Fi network is malicious
- Whether an app opened via deep link is safe
- Whether content is "completely safe"

## How to run the application

### Prerequisites

- Flutter 3.x (Dart 3.x)
- Android SDK (for Android builds)
- Xcode (for iOS builds, macOS only)

### Install dependencies

```bash
flutter pub get
```

### Generate code (Freezed, Drift, JSON serializable)

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Run the app

```bash
flutter run
```

## How to test it

### Unit and widget tests

```bash
flutter test
```

### Integration tests

```bash
flutter test integration_test
```

### Static analysis

```bash
flutter analyze
```

### Formatting

```bash
dart format lib test integration_test
```

## How to produce Android and iOS builds

### Android

```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

## Project structure

```
lib/
  app/              # App shell, router, theme, bootstrap, config
  core/
    database/       # Drift database, tables, DAOs
    services/       # Riverpod providers, settings, logging, error handling
  features/
    scanner/        # domain (models, services) + presentation
    analysis/       # domain (risk, actions) + presentation
    history/        # presentation
    favourites/     # presentation
    settings/       # domain + presentation
    privacy/        # presentation
    export/         # presentation
    onboarding/     # presentation
test/               # Unit and widget tests
integration_test/   # Integration tests
docs/               # PRD, threat model, ADRs
```

## Documentation

- [Product Requirements Document](docs/PRD.md)
- [Threat Model](docs/threat-model.md)
- [Architecture Decision Records](docs/adr/README.md)

## CI

GitHub Actions runs formatting, static analysis, and tests on every push and pull request. See [`.github/workflows/ci.yml`](.github/workflows/ci.yml).

## Licence

This project is not currently licensed for public distribution. All rights reserved.
