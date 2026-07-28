import 'package:flutter/material.dart';

import 'design_tokens.dart';

/// Qriora theme configuration.
///
/// The visual language communicates safety, privacy, clarity,
/// intelligence, and trust. It avoids alarmist red screens,
/// excessive gradients, and misleading security shields.
///
/// All colours, radii, and spacing values are sourced from
/// [QrioraDesignTokens] to ensure consistency.
class QrioraTheme {
  QrioraTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: QrioraDesignTokens.primaryBrand,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          scrolledUnderElevation: 0.5,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(QrioraDesignTokens.radiusLg),
            side: BorderSide(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(QrioraDesignTokens.radiusMd),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(QrioraDesignTokens.radiusMd),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(QrioraDesignTokens.radiusMd),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: QrioraDesignTokens.primaryBrand,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          scrolledUnderElevation: 0.5,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Colors.grey.shade800,
              width: 1,
            ),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
        ),
      );

  static ThemeData get highContrastLight => light.copyWith(
        colorScheme: const ColorScheme.highContrastLight(
          primary: QrioraDesignTokens.primaryBrandHighContrastLight,
          secondary: Color(0xFF004D4D),
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        textTheme: light.textTheme.copyWith(
          bodyLarge: const TextStyle(fontSize: 18, color: Colors.black),
          bodyMedium: const TextStyle(fontSize: 16, color: Colors.black),
          titleLarge: const TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      );

  static ThemeData get highContrastDark => dark.copyWith(
        colorScheme: const ColorScheme.highContrastDark(
          primary: QrioraDesignTokens.primaryBrandHighContrastDark,
          secondary: Color(0xFF9DEEEE),
          surface: Colors.black,
          onSurface: Colors.white,
        ),
        textTheme: dark.textTheme.copyWith(
          bodyLarge: const TextStyle(fontSize: 18, color: Colors.white),
          bodyMedium: const TextStyle(fontSize: 16, color: Colors.white),
          titleLarge: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      );
}
