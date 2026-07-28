import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'config/app_config.dart';
import '../core/services/error_handling.dart';
import '../core/services/qriora_logger.dart';

/// Bootstrap function — entry point for the application.
///
/// Configures global error handlers, privacy-safe logging, and wraps
/// the app in a [ProviderScope] for Riverpod dependency injection.
void bootstrap() {
  final config = AppConfig.current;

  if (config.enableLogging) {
    QrioraLogger.setLevel(config.logLevel);
  } else {
    QrioraLogger.setLevel(LogLevel.none);
  }

  configureErrorHandlers();

  QrioraLogger.info('lifecycle', 'App starting (${config.environment.name})');

  runApp(
    ProviderScope(
      observers: [QrioraProviderObserver()],
      child: const QrioraApp(),
    ),
  );
}
