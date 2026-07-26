import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router.dart';
import 'theme/qriora_theme.dart';
import '../core/services/providers.dart';
import '../features/settings/domain/user_settings.dart';

/// Root application widget.
class QrioraApp extends ConsumerWidget {
  final String? initialLocation;

  const QrioraApp({super.key, this.initialLocation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final router = createRouter(initialLocation: initialLocation);

    final theme = _selectTheme(settings);
    final darkTheme = _selectDarkTheme(settings);
    final themeMode = _selectThemeMode(settings);

    return MaterialApp.router(
      title: 'Qriora',
      debugShowCheckedModeBanner: false,
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }

  ThemeData _selectTheme(UserSettings settings) {
    if (settings.highContrast) {
      return QrioraTheme.highContrastLight;
    }
    return QrioraTheme.light;
  }

  ThemeData _selectDarkTheme(UserSettings settings) {
    if (settings.highContrast) {
      return QrioraTheme.highContrastDark;
    }
    return QrioraTheme.dark;
  }

  ThemeMode _selectThemeMode(UserSettings settings) {
    switch (settings.themePreference) {
      case ThemePreference.light:
        return ThemeMode.light;
      case ThemePreference.dark:
        return ThemeMode.dark;
      case ThemePreference.system:
        return ThemeMode.system;
    }
  }
}
