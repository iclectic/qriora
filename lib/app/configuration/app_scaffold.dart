import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Main scaffold with bottom navigation.
///
/// Wraps the four primary tabs: Scan, History, Favourites, Settings.
class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  static const _tabs = [
    _TabConfig(path: '/scan', icon: Icons.qr_code_scanner, label: 'Scan'),
    _TabConfig(path: '/history', icon: Icons.history, label: 'History'),
    _TabConfig(path: '/favourites', icon: Icons.star_outline, label: 'Favourites'),
    _TabConfig(path: '/settings', icon: Icons.settings_outlined, label: 'Settings'),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    for (var i = _tabs.length - 1; i >= 0; i--) {
      if (location.startsWith(_tabs[i].path)) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final index = _currentIndex(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => context.go(_tabs[i].path),
        destinations: _tabs.map((t) => NavigationDestination(
          icon: Icon(t.icon),
          selectedIcon: Icon(t.selectedIcon),
          label: t.label,
        )).toList(),
      ),
    );
  }
}

class _TabConfig {
  final String path;
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const _TabConfig({
    required this.path,
    required this.icon,
    required this.label,
  }) : selectedIcon = icon;
}
