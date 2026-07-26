import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:qriora/core/services/providers.dart';
import 'package:qriora/features/onboarding/presentation/onboarding_screen.dart';

/// A fake secure storage that stores values in memory.
class _FakeSecureStorage implements FlutterSecureStorage {
  final Map<String, String> _store = {};

  @override
  AndroidOptions get aOptions => const AndroidOptions();

  @override
  IOSOptions get iOptions => const IOSOptions();

  @override
  LinuxOptions get lOptions => const LinuxOptions();

  @override
  MacOsOptions get mOptions => const MacOsOptions();

  @override
  WindowsOptions get wOptions => const WindowsOptions();

  @override
  WebOptions get webOptions => const WebOptions();

  @override
  Future<bool> containsKey({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) {
    return Future.value(_store.containsKey(key));
  }

  @override
  Future<void> delete({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    _store.remove(key);
  }

  @override
  Future<void> deleteAll({
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    _store.clear();
  }

  @override
  Future<String?> read({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    return _store[key];
  }

  @override
  Future<Map<String, String>> readAll({
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    return Map.from(_store);
  }

  @override
  Future<void> write({
    required String key,
    required String? value,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    if (value != null) _store[key] = value;
  }

  @override
  Future<bool?> isCupertinoProtectedDataAvailable() async => false;

  @override
  Stream<bool> get onCupertinoProtectedDataAvailabilityChanged =>
      const Stream.empty();

  @override
  void registerListener({required String key, required ValueChanged<String?> listener}) {}

  @override
  void unregisterAllListeners() {}

  @override
  void unregisterAllListenersForKey({required String key}) {}

  @override
  void unregisterListener({required String key, required ValueChanged<String?> listener}) {}
}

void main() {
  group('OnboardingScreen', () {
    testWidgets('displays Qriora title and tagline', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            secureStorageProvider.overrideWithValue(_FakeSecureStorage()),
          ],
          child: const MaterialApp(
            home: OnboardingScreen(),
          ),
        ),
      );

      expect(find.text('Qriora'), findsOneWidget);
      expect(find.text('Know before you open.'), findsOneWidget);
    });

    testWidgets('displays three onboarding steps', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            secureStorageProvider.overrideWithValue(_FakeSecureStorage()),
          ],
          child: const MaterialApp(
            home: OnboardingScreen(),
          ),
        ),
      );

      expect(find.text('Privacy first'), findsOneWidget);
      expect(find.text('Explainable risk analysis'), findsOneWidget);
      expect(find.text('You stay in control'), findsOneWidget);
    });

    testWidgets('displays Get started and Skip buttons', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            secureStorageProvider.overrideWithValue(_FakeSecureStorage()),
          ],
          child: const MaterialApp(
            home: OnboardingScreen(),
          ),
        ),
      );

      expect(find.text('Get started'), findsOneWidget);
      expect(find.text('Skip'), findsOneWidget);
    });

    testWidgets('displays QR scanner icon', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            secureStorageProvider.overrideWithValue(_FakeSecureStorage()),
          ],
          child: const MaterialApp(
            home: OnboardingScreen(),
          ),
        ),
      );

      expect(find.byIcon(Icons.qr_code_scanner), findsOneWidget);
    });

    testWidgets('tapping Get started completes onboarding', (tester) async {
      final storage = _FakeSecureStorage();

      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const OnboardingScreen(),
          ),
          GoRoute(
            path: '/scan',
            builder: (context, state) => const Scaffold(body: Text('Scan')),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            secureStorageProvider.overrideWithValue(storage),
          ],
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      await tester.tap(find.text('Get started'));
      await tester.pumpAndSettle();

      final stored = await storage.read(key: 'user_settings');
      expect(stored, isNotNull);
      expect(stored, contains('hasCompletedOnboarding=true'));
    });
  });
}
