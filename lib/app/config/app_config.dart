import 'package:flutter/foundation.dart';

import '../../core/services/qriora_logger.dart';

/// Application environment.
enum AppEnvironment {
  development,
  staging,
  production,
}

/// Environment configuration for the application.
///
/// Provides environment-specific values without committing secrets.
/// The active environment is determined at compile time via
/// [kDebugMode] and can be overridden for testing.
class AppConfig {
  const AppConfig({
    required this.environment,
    required this.appName,
    required this.enableLogging,
    required this.logLevel,
  });

  /// Development configuration.
  static const development = AppConfig(
    environment: AppEnvironment.development,
    appName: 'Qriora (Dev)',
    enableLogging: true,
    logLevel: LogLevel.debug,
  );

  /// Staging configuration.
  static const staging = AppConfig(
    environment: AppEnvironment.staging,
    appName: 'Qriora (Staging)',
    enableLogging: true,
    logLevel: LogLevel.info,
  );

  /// Production configuration.
  static const production = AppConfig(
    environment: AppEnvironment.production,
    appName: 'Qriora',
    enableLogging: false,
    logLevel: LogLevel.warning,
  );

  final AppEnvironment environment;
  final String appName;
  final bool enableLogging;
  final LogLevel logLevel;

  /// Returns the active configuration based on [kDebugMode].
  static AppConfig get current {
    if (kDebugMode) return development;
    return production;
  }

  /// Whether the app is running in development mode.
  bool get isDevelopment => environment == AppEnvironment.development;

  /// Whether the app is running in staging mode.
  bool get isStaging => environment == AppEnvironment.staging;

  /// Whether the app is running in production mode.
  bool get isProduction => environment == AppEnvironment.production;
}
