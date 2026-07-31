# Qriora Privacy Policy

**Last updated: 2025-07-30**

## Overview

Qriora is a privacy-first QR code and barcode scanner. This privacy policy explains how Qriora handles your data.

## The Short Version

**Qriora does not collect, transmit, or share any personal data.** All scanning, analysis, and storage happens entirely on your device.

---

## Data We Do NOT Collect

- **Scanned content** — QR code/barcode values are never sent to any server.
- **Personal information** — No names, emails, phone numbers, or account data are collected.
- **Usage analytics** — No crash reports, usage metrics, or telemetry are sent.
- **Location data** — Qriora does not access or transmit your location.

## Data Stored On Your Device

| Data | Purpose | User Control |
|---|---|---|
| Scan history | Allows you to review past scans | Configurable retention period (7/30/90 days or never expire). Can be deleted at any time. |
| App settings | Remembers your preferences | Stored in device secure storage. Cleared when app is uninstalled. |
| Analysis reports | User feedback on incorrect findings | Stored locally in secure storage. Never transmitted. |

## Private Mode

When Private Mode is enabled, scans are not saved to the device's database at all. No trace of scanned content remains after you leave the result screen.

## Network Access

Qriora does **not** make any network calls for analysis. All risk analysis is performed locally on your device.

An optional setting `allowNetworkLookups` exists but is **disabled by default**. Even when enabled, Qriora only performs DNS lookups to help identify suspicious domains — no scanned content is sent to third-party services.

## Encryption

- Scan history is stored in a local SQLite database.
- Sensitive settings (e.g., biometric lock state) are stored in platform secure storage (Android Keystore / iOS Keychain).
- Export files are encrypted with AES-256 using a user-provided password.

## Screenshot Protection

On Android, Qriora blocks screenshots and screen recording on screens displaying scanned content (scan result, raw content view) by using the `FLAG_SECURE` window flag.

On iOS, screenshot prevention is not supported via public APIs. Users should exercise caution when viewing sensitive content on iOS devices.

## Biometric Lock

Qriora offers an optional biometric lock (fingerprint/face recognition) to prevent unauthorised access to the app. Biometric authentication is performed locally by the operating system — no biometric data is collected or transmitted by Qriora.

## Third-Party Services

Qriora does **not** integrate any third-party analytics, advertising, or tracking SDKs.

## Children's Privacy

Qriora is not directed at children and does not knowingly collect any data from anyone, including children.

## Your Rights

Since Qriora does not collect any data, there is no data to access, correct, or delete on any server. All data on your device can be:

- **Deleted** — via the "Delete all data" option in Settings > Export & import.
- **Exported** — via the encrypted export feature in Settings > Export & import.
- **Controlled** — via retention settings and private mode.

## Open Source Transparency

Qriora's source code is available for review. The analysis engine, data storage, and network behaviour can be independently verified.

## Changes to This Policy

If Qriora's data practices change, this privacy policy will be updated. Any changes will be noted with an updated "Last updated" date.

## Contact

For privacy questions or concerns, please open an issue on the Qriora repository.

---

**Qriora: Know before you open.**
