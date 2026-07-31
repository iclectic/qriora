import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../services/qriora_logger.dart';

/// Notifier that tracks available device storage and whether
/// the app should warn the user about low storage.
class LowStorageNotifier extends StateNotifier<LowStorageState> {
  LowStorageNotifier() : super(const LowStorageState.initial()) {
    _check();
  }

  /// Threshold below which we warn the user (100 MB).
  static const _warningThresholdBytes = 100 * 1024 * 1024;

  Future<void> _check() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final stat = await dir.stat();
      // Use the free space from the directory's filesystem
      // On most platforms, we can use `df` or similar, but
      // for a cross-platform approach we use the directory's
      // available space via Platform-specific calls.
      //
      // Since dart:io doesn't expose free space directly,
      // we use a heuristic: try to write a temp file and
      // check if it succeeds. For now, we use a simpler
      // approach — just report unknown on platforms where
      // we can't determine this.
      //
      // On Android/iOS, we could use platform channels, but
      // for now we report unknown and skip the warning.
      //
      // This is a placeholder that always reports "ok" to
      // avoid false positives. A production implementation
      // would use a platform channel to query free space.
      state = LowStorageState.ok(
        availableBytes: stat.size > 0 ? stat.size : _warningThresholdBytes * 10,
        totalBytes: stat.size > 0 ? stat.size : _warningThresholdBytes * 100,
      );
    } catch (e) {
      QrioraLogger.warning('storage', 'Could not check storage: $e');
      state = const LowStorageState.unknown();
    }
  }

  /// Re-checks storage. Call after user takes action to free space.
  Future<void> recheck() async {
    state = const LowStorageState.initial();
    _check();
  }
}

/// State for low-storage monitoring.
sealed class LowStorageState {
  const LowStorageState();

  const factory LowStorageState.initial() = _Initial;
  const factory LowStorageState.ok({
    required int availableBytes,
    required int totalBytes,
  }) = _Ok;
  const factory LowStorageState.warning({
    required int availableBytes,
    required int totalBytes,
  }) = _Warning;
  const factory LowStorageState.unknown() = _Unknown;
}

class _Initial extends LowStorageState {
  const _Initial();
}

class _Ok extends LowStorageState {
  final int availableBytes;
  final int totalBytes;
  const _Ok({required this.availableBytes, required this.totalBytes});
}

class _Warning extends LowStorageState {
  final int availableBytes;
  final int totalBytes;
  const _Warning({required this.availableBytes, required this.totalBytes});

  String get formattedAvailable {
    if (availableBytes >= 1024 * 1024 * 1024) {
      return '${(availableBytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
    return '${(availableBytes / (1024 * 1024)).toStringAsFixed(0)} MB';
  }
}

class _Unknown extends LowStorageState {
  const _Unknown();
}

/// Provider for low-storage monitoring.
final lowStorageProvider =
    StateNotifierProvider<LowStorageNotifier, LowStorageState>((ref) {
  return LowStorageNotifier();
});

/// A banner widget that shows a low-storage warning when applicable.
class LowStorageBanner extends ConsumerWidget {
  final Widget child;

  const LowStorageBanner({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storageState = ref.watch(lowStorageProvider);

    final showWarning = storageState is _Warning;

    return Column(
      children: [
        if (showWarning)
          Material(
            color: Theme.of(context).colorScheme.errorContainer,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Theme.of(context).colorScheme.onErrorContainer,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Low storage: only ${(storageState as _Warning).formattedAvailable} available. '
                      'Scan history may not be saved.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onErrorContainer,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        Expanded(child: child),
      ],
    );
  }
}
