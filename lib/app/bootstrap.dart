import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

/// Bootstrap function — entry point for the application.
///
/// Wraps the app in a [ProviderScope] for Riverpod dependency injection.
void bootstrap() {
  runApp(
    const ProviderScope(
      child: QrioraApp(),
    ),
  );
}
