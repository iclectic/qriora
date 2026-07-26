# Qriora — Threat Model

**Version:** 1.0.0  
**Last updated:** 2026-07-26  
**Methodology:** Lightweight STRIDE-based analysis

---

## 1. Scope

This threat model covers the Qriora mobile application (iOS and Android) for v1.0.0. It identifies assets, threat agents, attack surfaces, and mitigations.

---

## 2. Assets

| Asset | Location | Sensitivity |
|---|---|---|
| Scanned content (raw values) | In-memory during analysis, optionally in SQLite DB | High — may contain URLs, credentials, PII |
| Scan history | On-device SQLite database (`qriora.db`) | Medium — reveals user behaviour patterns |
| User settings | flutter_secure_storage (Keystore/Keychain) | Medium — includes privacy preferences |
| Wi-Fi credentials | In-memory during analysis, optionally in DB | High — SSID + password |
| Contact data (vCard) | In-memory during analysis, optionally in DB | High — names, phone numbers, emails |
| App lock state | In-memory | Low — boolean |

---

## 3. Threat agents

| Agent | Capability | Motivation |
|---|---|---|
| Malicious QR code creator | Crafts QR codes with phishing URLs, Wi-Fi creds, malicious deep links | Wide attack surface — anyone who scans the code |
| Physical device thief | Has physical access to unlocked or locked device | Access scan history, saved favourites |
| Network observer | On same network as user | Limited — app makes no network calls for analysis |
| Malicious app on device | Sandboxed app with network access | Cannot access Qriora's SQLite DB directly, but may attempt intent interception |

---

## 4. STRIDE analysis

### 4.1 Spoofing

| Threat | Mitigation |
|---|---|
| Malicious QR code impersonates a legitimate service via shortened URL | `url-shortener` rule flags shortened domains with caution severity |
| QR code contains URL with embedded credentials to spoof domain | `url-embedded-credentials` rule flags as high risk |
| Deep link spoofs a legitimate app | `deeplink-unknown-app` rule flags unknown deep link schemes |

### 4.2 Tampering

| Threat | Mitigation |
|---|---|
| Attacker modifies scan history in SQLite DB | Requires root/jailbreak. DB is in app-private storage. Biometric lock adds friction. |
| Attacker modifies settings to disable private mode | Settings stored in secure storage (Keystore/Keychain). Requires device unlock. |
| Man-in-the-middle modifies scanned content | Not applicable — scanning is optical, not network-based. |

### 4.3 Repudiation

| Threat | Mitigation |
|---|---|
| User denies scanning a particular code | Scan history records timestamp, content type, and source. Private mode disables recording (by design). |

### 4.4 Information disclosure

| Threat | Mitigation |
|---|---|
| Scan history reveals sensitive scanning behaviour | Private mode prevents persistence. Retention policy auto-purges old records. User can delete all data. |
| Wi-Fi password visible in UI | `maskSensitiveValues` setting defaults to `true`. Wi-Fi content type is marked sensitive. Content preview masks values. |
| Screen recording / shoulder surfing | Sensitive values masked by default. `reducedMotion` does not affect masking. |
| DB file extracted via backup | On iOS, `NSFileProtectionComplete` applied via sqlite3_flutter_libs. On Android, app-private storage requires root. |
| Settings file read by attacker | Stored in flutter_secure_storage (platform keychain/keystore). |

### 4.5 Denial of service

| Threat | Mitigation |
|---|---|
| Extremely large QR code causes OOM | Payload size is not currently capped. **Mitigation needed:** add max length check in `PayloadParser`. |
| Malformed payload causes parser crash | `PayloadParser` wraps parsing in try-catch. Unparseable content classified as `malformed`. |
| Rapid scanning floods database | Private mode skips DB writes. Deduplication setting (`deduplicateScans`) prevents identical consecutive scans. |

### 4.6 Elevation of privilege

| Threat | Mitigation |
|---|---|
| Bypass biometric lock | Biometric lock is app-level, not OS-level. Falls back to device PIN if biometrics unavailable. Not a security boundary — defence in depth. |
| Bypass private mode via DB direct access | Requires root/jailbreak. Out of scope for v1. |

---

## 5. Attack surface

### 5.1 QR code content (primary attack surface)

The entire attack surface is the content of the scanned code. Qriora treats all scanned content as untrusted.

**Mitigations:**
- Content is classified, parsed, and analysed before any action is offered.
- No action is performed without explicit user confirmation (except Copy/Share/Dismiss/Rescan).
- Risk findings are displayed before actions.
- Raw content is shown in a separate screen for manual inspection.

### 5.2 Local database

**Mitigations:**
- App-private storage (not shared).
- Retention policy auto-purges.
- User can delete all data from Settings.
- Favourites can be preserved or purged with history (user choice).

### 5.3 Settings

**Mitigations:**
- Stored in platform secure storage.
- No settings are transmitted over the network.

### 5.4 Export

**Mitigations:**
- Export is user-initiated.
- Exported JSON contains scan history only — no settings or secure storage data.
- User is informed before export.

---

## 6. Residual risks

| Risk | Severity | Notes |
|---|---|---|
| No payload size limit | Medium | Could cause OOM with extremely large barcodes. Fix planned. |
| No URL reputation lookup | Medium | Deterministic rules catch known patterns but cannot detect zero-day phishing domains. Opt-in lookup planned for v1.1. |
| Biometric lock is app-level only | Low | Determined attacker with device unlock can bypass. Acceptable for v1. |
| No database encryption | Low | SQLite DB is in app-private storage but not encrypted. Full DB encryption planned for v1.1 (SQLCipher). |
| Deep link target verification | Low | Qriora warns about unknown deep links but cannot verify if the target app is installed or safe. |

---

## 7. Security principles enforced

1. **Never auto-open** — Qriora never opens a URL, joins a network, or performs any action without explicit user confirmation.
2. **No network for analysis** — all classification, parsing, and risk analysis is on-device.
3. **Explain before act** — the user sees what the content is, what it will do, and what risks were found before deciding.
4. **Absence of evidence is not evidence of absence** — every result includes a disclaimer that no warnings does not mean safe.
5. **User controls data** — private mode, retention policy, manual deletion, and export are all user-controlled.
