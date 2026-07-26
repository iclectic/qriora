import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';

import '../../../core/services/providers.dart';

/// App lock screen — biometric authentication gate.
class AppLockScreen extends ConsumerStatefulWidget {
  const AppLockScreen({super.key});

  @override
  ConsumerState<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends ConsumerState<AppLockScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  Future<void> _authenticate() async {
    try {
      final didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to unlock Qriora',
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );
      if (didAuthenticate && mounted) {
        context.go('/scan');
      }
    } catch (_) {
      // Stay on lock screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text('Qriora is locked', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              const Text('Authenticate to continue'),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _authenticate,
                icon: const Icon(Icons.fingerprint),
                label: const Text('Unlock'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  ref.read(settingsProvider.notifier).setBiometricLock(false);
                  context.go('/scan');
                },
                child: const Text('Disable biometric lock'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
