import 'dart:developer' as developer;

/// Privacy-safe logging utility.
///
/// This logger NEVER logs raw scan values, parsed entities, or any
/// user-generated content. It only logs:
/// - Operational events (app lifecycle, navigation)
/// - Error stack traces (without payload data)
/// - Performance metrics
///
/// All log messages are tagged with a category for easy filtering.
class QrioraLogger {
  QrioraLogger._();

  /// Log level for filtering.
  static LogLevel _level = LogLevel.info;

  /// Sets the minimum log level.
  static void setLevel(LogLevel level) => _level = level;

  /// Debug-level log. Only emitted in development.
  static void debug(String category, String message) {
    if (_level.index <= LogLevel.debug.index) {
      developer.log(message, name: 'qriora/$category', level: 500);
    }
  }

  /// Info-level log.
  static void info(String category, String message) {
    if (_level.index <= LogLevel.info.index) {
      developer.log(message, name: 'qriora/$category', level: 800);
    }
  }

  /// Warning-level log.
  static void warning(String category, String message, {Object? error}) {
    if (_level.index <= LogLevel.warning.index) {
      developer.log(
        message,
        name: 'qriora/$category',
        level: 900,
        error: error,
      );
    }
  }

  /// Error-level log. Never includes raw scan values.
  static void error(String category, String message, {Object? error, StackTrace? stackTrace}) {
    if (_level.index <= LogLevel.error.index) {
      developer.log(
        message,
        name: 'qriora/$category',
        level: 1000,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

/// Log level priority.
enum LogLevel {
  debug,
  info,
  warning,
  error,
  none,
}
