import 'package:go_router/go_router.dart';

import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/scanner/presentation/scanner_screen.dart';
import '../features/scanner/presentation/manual_entry_screen.dart';
import '../features/analysis/presentation/scan_result_screen.dart';
import '../features/analysis/presentation/risk_explanation_screen.dart';
import '../features/analysis/presentation/raw_content_screen.dart';
import '../features/history/presentation/history_screen.dart';
import '../features/favourites/presentation/favourites_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/settings/presentation/about_screen.dart';
import '../features/privacy/presentation/privacy_screen.dart';
import '../features/export/presentation/export_screen.dart';
import '../features/settings/presentation/app_lock_screen.dart';
import '../features/settings/presentation/feedback_screen.dart';
import 'configuration/app_scaffold.dart';

/// Application router configuration.
///
/// Routes are restorable and use a bottom-navigation shell
/// for the main tabs: Scan, History, Favourites, Settings.
GoRouter createRouter({String? initialLocation}) {
  return GoRouter(
    initialLocation: initialLocation ?? '/onboarding',
    routes: [
      // Onboarding (outside the shell)
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // App lock (outside the shell)
      GoRoute(
        path: '/lock',
        builder: (context, state) => const AppLockScreen(),
      ),

      // Main shell with bottom navigation
      ShellRoute(
        builder: (context, state, child) => AppScaffold(child: child),
        routes: [
          GoRoute(
            path: '/scan',
            builder: (context, state) => const ScannerScreen(),
          ),
          GoRoute(
            path: '/history',
            builder: (context, state) => const HistoryScreen(),
          ),
          GoRoute(
            path: '/favourites',
            builder: (context, state) => const FavouritesScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
            routes: [
              GoRoute(
                path: 'about',
                builder: (context, state) => const AboutScreen(),
              ),
              GoRoute(
                path: 'privacy',
                builder: (context, state) => const PrivacyScreen(),
              ),
              GoRoute(
                path: 'export',
                builder: (context, state) => const ExportScreen(),
              ),
              GoRoute(
                path: 'feedback',
                builder: (context, state) => const FeedbackScreen(),
              ),
            ],
          ),
        ],
      ),

      // Scan result (outside shell — full screen)
      GoRoute(
        path: '/result/:id',
        builder: (context, state) => ScanResultScreen(
          scanId: state.pathParameters['id']!,
        ),
      ),

      // Risk explanation
      GoRoute(
        path: '/result/:id/risk/:findingIndex',
        builder: (context, state) => RiskExplanationScreen(
          scanId: state.pathParameters['id']!,
          findingIndex: int.parse(state.pathParameters['findingIndex']!),
        ),
      ),

      // Raw content view
      GoRoute(
        path: '/result/:id/raw',
        builder: (context, state) => RawContentScreen(
          scanId: state.pathParameters['id']!,
        ),
      ),

      // Manual entry
      GoRoute(
        path: '/manual-entry',
        builder: (context, state) => const ManualEntryScreen(),
      ),
    ],
  );
}
