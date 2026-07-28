# Qriora — Architecture Decision Records

**Last updated:** 2026-07-26

---

## ADR-001: On-device analysis only (no network calls)

**Date:** 2026-07-26  
**Status:** Accepted

### Context

QR code scanners typically send scanned URLs to a cloud reputation service to check for phishing/malware. This creates a privacy issue: the scanning service sees every URL the user scans, including potentially sensitive URLs (banking, health, internal corporate links).

### Decision

Qriora performs **all analysis on-device** using deterministic rules. No scanned content is transmitted over the network. The `allowNetworkLookups` setting exists in the settings model but defaults to `false` and is not wired to any network call in v1.

### Consequences

- **Positive:** Zero privacy footprint. Works offline. No server costs. No latency from network calls.
- **Negative:** Cannot detect zero-day phishing domains. Detection limited to known patterns (URL shorteners, embedded credentials, IP hosts, suspicious keywords).
- **Future:** Opt-in URL reputation lookup planned for v1.1 with explicit user consent.

---

## ADR-002: Never auto-open scanned content

**Date:** 2026-07-26  
**Status:** Accepted

### Context

Many QR scanners automatically open URLs or perform actions immediately after scanning. This is dangerous because the user has no opportunity to review the content before the action is taken.

### Decision

Qriora **never automatically opens a link, joins a network, dials a number, or performs any action**. Every action that modifies state or launches an external app requires explicit user confirmation. Only Copy, Share, Save to Favourites, Add Note, Dismiss, and Rescan do not require confirmation.

### Consequences

- **Positive:** User always has the opportunity to review risk findings before acting. Reduces phishing effectiveness.
- **Negative:** Extra tap required for every action. Acceptable trade-off for a security-focused app.

---

## ADR-003: Riverpod for state management and DI

**Date:** 2026-07-26  
**Status:** Accepted

### Context

Flutter offers multiple state management options: Provider, Riverpod, BLoC, GetX, MobX. The app needs dependency injection (database, secure storage), stateful state (settings, scan results), and testability.

### Decision

Use **Riverpod 2.x** for all state management and dependency injection.

### Consequences

- **Positive:** Compile-safe providers. Excellent testability via `ProviderScope` overrides. No `BuildContext` dependency for provider reads. Fine-grained rebuilds.
- **Negative:** Learning curve for developers unfamiliar with Riverpod. Slightly more boilerplate than Provider.

---

## ADR-004: Drift (SQLite) for local persistence

**Date:** 2026-07-26  
**Status:** Accepted

### Context

The app needs to store scan history locally with structured querying (filter by type, date, favourite status). Options: Hive, Isar, Drift, shared_preferences + JSON.

### Decision

Use **Drift** (SQLite-based ORM) for scan history persistence.

### Consequences

- **Positive:** Type-safe queries. Migration support. Familiar SQL paradigm. Good test support with in-memory database. Works with sqlite3_flutter_libs for platform compatibility.
- **Negative:** Code generation step required. Larger binary size than key-value stores.
- **Future:** SQLCipher integration planned for v1.1 to encrypt the database at rest.

---

## ADR-005: Freezed for immutable domain models

**Date:** 2026-07-26  
**Status:** Accepted

### Context

Domain models (ScanRecord, ScanPayload, AnalysisResult, RiskFinding, SuggestedAction, etc.) need immutability, copyWith, equality, and JSON serialization.

### Decision

Use **Freezed** with `json_serializable` for all domain models.

### Consequences

- **Positive:** Immutable by default. Generated `copyWith`, `==`, `hashCode`, `toString`. JSON serialization via `fromJson`/`toJson`. Union types for sealed hierarchies if needed.
- **Negative:** Code generation required. `.freezed.dart` and `.g.dart` files must be excluded from linting.

---

## ADR-006: go_router for navigation

**Date:** 2026-07-26  
**Status:** Accepted

### Context

The app has multiple features (scanner, analysis, history, favourites, settings, privacy, export, onboarding) with deep-linkable routes.

### Decision

Use **go_router** for declarative routing.

### Consequences

- **Positive:** Declarative route configuration. Deep linking support. Redirect guards (e.g., onboarding check). Web-compatible.
- **Negative:** Router state management adds complexity for simple flows.

---

## ADR-007: Risk severity communicated via icons + labels, not colour alone

**Date:** 2026-07-26  
**Status:** Accepted

### Context

Colour-only risk indicators are inaccessible to colour-blind users and fail WCAG 2.1 success criterion 1.4.1 (Use of Color).

### Decision

Every risk severity level has a **distinct icon, text label, and explanatory paragraph** in addition to any colour treatment. The `RiskSeverity` enum defines `label` and `explanation` getters. The UI renders these alongside any colour-based visual cue.

### Consequences

- **Positive:** Accessible to all users regardless of colour vision. Clearer communication. Compliant with WCAG 2.1.
- **Negative:** Slightly more screen space used for risk display.

---

## ADR-008: Deterministic rules over ML for risk analysis (v1)

**Date:** 2026-07-26  
**Status:** Accepted

### Context

Risk analysis could use deterministic rules (regex, pattern matching) or a machine learning model. ML models require training data, model shipping, and potentially network calls for inference.

### Decision

Use **deterministic rules** for all risk analysis in v1. Each rule is a pure function that examines the parsed payload and returns findings. Rules are versioned via `AnalysisVersion`.

### Consequences

- **Positive:** Fully transparent — every finding has a clear rule ID and explanation. No training data needed. No model size overhead. Works offline. Deterministic and testable.
- **Negative:** Cannot detect novel phishing patterns. Limited to known indicators. May produce false negatives for sophisticated attacks.
- **Future:** On-device ML model planned for v2.0 as an additional signal, not a replacement for rules.

---

## ADR-009: Private mode disables persistence entirely

**Date:** 2026-07-26  
**Status:** Accepted

### Context

Private mode could be implemented as: (a) encrypt history, (b) store in memory only, or (c) skip database writes entirely.

### Decision

When private mode is enabled, **scans are not written to the database at all**. The scan result is shown in-memory and discarded when the user navigates away.

### Consequences

- **Positive:** No trace of scanning activity. Simple implementation. No decryption key management.
- **Negative:** User cannot access private-mode scans in history. Acceptable — this is the intended behaviour.

---

## ADR-010: Absence-of-warnings disclaimer on every result

**Date:** 2026-07-26  
**Status:** Accepted

### Context

Users may interpret "no warnings found" as "this content is safe." This is a dangerous false sense of security.

### Decision

Every `AnalysisResult` includes a `limitations` list and the summary text explicitly states: *"This does not mean the content is completely safe."* The UI always displays these limitations.

### Consequences

- **Positive:** Manages user expectations. Reduces liability. Reinforces the "user-in-the-loop" principle.
- **Negative:** May feel overly cautious to users. Acceptable for a security-focused app.
