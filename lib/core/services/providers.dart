import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../features/settings/domain/user_settings.dart';
import '../../features/settings/domain/retention_policy.dart';
import '../../features/analysis/domain/analysis_report_service.dart';
import '../database/qriora_database.dart';

/// Provides the [QrioraDatabase] instance.
final databaseProvider = Provider<QrioraDatabase>((ref) {
  final db = QrioraDatabase();
  ref.onDispose(db.close);
  return db;
});

/// Provides a [FlutterSecureStorage] instance for sensitive key storage.
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
});

/// Settings state notifier.
class SettingsNotifier extends StateNotifier<UserSettings> {
  final FlutterSecureStorage _storage;
  static const _key = 'user_settings';

  SettingsNotifier(this._storage) : super(const UserSettings()) {
    _load();
  }

  Future<void> _load() async {
    final json = await _storage.read(key: _key);
    if (json != null) {
      try {
        // Simple manual parse since we store as key=value pairs
        final settings = _parseStoredSettings(json);
        state = settings;
      } catch (_) {
        // Keep defaults on parse error
      }
    }
  }

  Future<void> _save() async {
    final encoded = _encodeSettings(state);
    await _storage.write(key: _key, value: encoded);
  }

  Future<void> update(UserSettings Function(UserSettings) updater) async {
    state = updater(state);
    await _save();
  }

  Future<void> setThemePreference(ThemePreference pref) =>
      update((s) => s.copyWith(themePreference: pref));

  Future<void> togglePrivateMode() =>
      update((s) => s.copyWith(privateMode: !s.privateMode));

  Future<void> setBiometricLock(bool enabled) =>
      update((s) => s.copyWith(biometricLockEnabled: enabled));

  Future<void> setSaveHistory(bool enabled) =>
      update((s) => s.copyWith(saveHistory: enabled));

  Future<void> setRetentionPolicy(RetentionPolicy policy) =>
      update((s) => s.copyWith(retentionPolicy: policy));

  Future<void> toggleMaskSensitiveValues() =>
      update((s) => s.copyWith(maskSensitiveValues: !s.maskSensitiveValues));

  Future<void> toggleReducedMotion() =>
      update((s) => s.copyWith(reducedMotion: !s.reducedMotion));

  Future<void> toggleHighContrast() =>
      update((s) => s.copyWith(highContrast: !s.highContrast));

  Future<void> toggleLargeText() =>
      update((s) => s.copyWith(largeText: !s.largeText));

  Future<void> setAllowNetworkLookups(bool enabled) =>
      update((s) => s.copyWith(allowNetworkLookups: enabled));

  Future<void> completeOnboarding() =>
      update((s) => s.copyWith(hasCompletedOnboarding: true));

  Future<void> toggleDeduplicateScans() =>
      update((s) => s.copyWith(deduplicateScans: !s.deduplicateScans));

  Future<void> toggleHapticFeedback() =>
      update((s) => s.copyWith(hapticFeedback: !s.hapticFeedback));

  Future<void> toggleSoundFeedback() =>
      update((s) => s.copyWith(soundFeedback: !s.soundFeedback));

  String _encodeSettings(UserSettings s) {
    final parts = <String>[];
    parts.add('themePreference=${s.themePreference.name}');
    parts.add('privateMode=${s.privateMode}');
    parts.add('biometricLockEnabled=${s.biometricLockEnabled}');
    parts.add('saveHistory=${s.saveHistory}');
    parts.add('retentionPeriod=${s.retentionPolicy.period.name}');
    parts.add('deleteFavouritesWithHistory=${s.retentionPolicy.deleteFavouritesWithHistory}');
    parts.add('maskSensitiveValues=${s.maskSensitiveValues}');
    parts.add('reducedMotion=${s.reducedMotion}');
    parts.add('highContrast=${s.highContrast}');
    parts.add('largeText=${s.largeText}');
    parts.add('allowNetworkLookups=${s.allowNetworkLookups}');
    parts.add('hasCompletedOnboarding=${s.hasCompletedOnboarding}');
    parts.add('deduplicateScans=${s.deduplicateScans}');
    parts.add('hapticFeedback=${s.hapticFeedback}');
    parts.add('soundFeedback=${s.soundFeedback}');
    return parts.join(';');
  }

  UserSettings _parseStoredSettings(String encoded) {
    final map = <String, String>{};
    for (final part in encoded.split(';')) {
      final kv = part.split('=');
      if (kv.length == 2) {
        map[kv[0]] = kv[1];
      }
    }
    return UserSettings(
      themePreference: ThemePreference.values.firstWhere(
        (e) => e.name == map['themePreference'],
        orElse: () => ThemePreference.system,
      ),
      privateMode: map['privateMode'] == 'true',
      biometricLockEnabled: map['biometricLockEnabled'] == 'true',
      saveHistory: map['saveHistory'] != 'false',
      retentionPolicy: RetentionPolicy(
        period: RetentionPeriod.values.firstWhere(
          (e) => e.name == map['retentionPeriod'],
          orElse: () => RetentionPeriod.thirtyDays,
        ),
        deleteFavouritesWithHistory: map['deleteFavouritesWithHistory'] == 'true',
      ),
      maskSensitiveValues: map['maskSensitiveValues'] != 'false',
      reducedMotion: map['reducedMotion'] == 'true',
      highContrast: map['highContrast'] == 'true',
      largeText: map['largeText'] == 'true',
      allowNetworkLookups: map['allowNetworkLookups'] == 'true',
      hasCompletedOnboarding: map['hasCompletedOnboarding'] == 'true',
      deduplicateScans: map['deduplicateScans'] != 'false',
      hapticFeedback: map['hapticFeedback'] != 'false',
      soundFeedback: map['soundFeedback'] == 'true',
    );
  }
}

/// Provides the [SettingsNotifier].
final settingsProvider =
    StateNotifierProvider<SettingsNotifier, UserSettings>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return SettingsNotifier(storage);
});

/// Provides the [AnalysisReportService].
final analysisReportServiceProvider = Provider<AnalysisReportService>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return AnalysisReportService(storage: storage);
});
