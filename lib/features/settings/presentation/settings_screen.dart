import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/providers.dart';
import '../../settings/domain/user_settings.dart';
import '../../settings/domain/retention_policy.dart';

/// Settings screen — main settings hub.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          _SectionHeader('Appearance'),
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text('Theme'),
            subtitle: Text(settings.themePreference.label),
            onTap: () => _showThemePicker(context, ref),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.contrast),
            title: const Text('High contrast'),
            value: settings.highContrast,
            onChanged: (_) => ref.read(settingsProvider.notifier).toggleHighContrast(),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.text_fields),
            title: const Text('Large text'),
            value: settings.largeText,
            onChanged: (_) => ref.read(settingsProvider.notifier).toggleLargeText(),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.animation),
            title: const Text('Reduced motion'),
            value: settings.reducedMotion,
            onChanged: (_) => ref.read(settingsProvider.notifier).toggleReducedMotion(),
          ),

          _SectionHeader('Privacy'),
          SwitchListTile(
            secondary: const Icon(Icons.lock_outline),
            title: const Text('Private mode'),
            subtitle: const Text('Scans are never saved'),
            value: settings.privateMode,
            onChanged: (_) => ref.read(settingsProvider.notifier).togglePrivateMode(),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.visibility_off_outlined),
            title: const Text('Mask sensitive values'),
            value: settings.maskSensitiveValues,
            onChanged: (_) => ref.read(settingsProvider.notifier).toggleMaskSensitiveValues(),
          ),
          ListTile(
            leading: const Icon(Icons.security_outlined),
            title: const Text('Privacy & data'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/settings/privacy'),
          ),

          _SectionHeader('Security'),
          SwitchListTile(
            secondary: const Icon(Icons.fingerprint),
            title: const Text('Biometric lock'),
            value: settings.biometricLockEnabled,
            onChanged: (v) => ref.read(settingsProvider.notifier).setBiometricLock(v),
          ),

          _SectionHeader('History'),
          SwitchListTile(
            secondary: const Icon(Icons.save_outlined),
            title: const Text('Save history'),
            value: settings.saveHistory,
            onChanged: (v) => ref.read(settingsProvider.notifier).setSaveHistory(v),
          ),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('Retention period'),
            subtitle: Text(settings.retentionPolicy.period.label),
            onTap: () => _showRetentionPicker(context, ref),
          ),

          _SectionHeader('Network'),
          SwitchListTile(
            secondary: const Icon(Icons.cloud_outlined),
            title: const Text('Allow network lookups'),
            subtitle: const Text('Optional — requires your consent each time'),
            value: settings.allowNetworkLookups,
            onChanged: (v) => ref.read(settingsProvider.notifier).setAllowNetworkLookups(v),
          ),

          _SectionHeader('Scanner'),
          SwitchListTile(
            secondary: const Icon(Icons.content_copy),
            title: const Text('Deduplicate consecutive scans'),
            value: settings.deduplicateScans,
            onChanged: (_) => ref.read(settingsProvider.notifier).toggleDeduplicateScans(),
          ),

          _SectionHeader('Data'),
          ListTile(
            leading: const Icon(Icons.file_download_outlined),
            title: const Text('Export & import'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/settings/export'),
          ),

          _SectionHeader('About'),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About Qriora'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/settings/about'),
          ),
          ListTile(
            leading: const Icon(Icons.feedback_outlined),
            title: const Text('Feedback'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/settings/feedback'),
          ),
        ],
      ),
    );
  }

  void _showThemePicker(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Choose theme'),
        children: ThemePreference.values.map((pref) {
          return SimpleDialogOption(
            onPressed: () {
              ref.read(settingsProvider.notifier).setThemePreference(pref);
              Navigator.of(ctx).pop();
            },
            child: Text(pref.label),
          );
        }).toList(),
      ),
    );
  }

  void _showRetentionPicker(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Retention period'),
        children: RetentionPeriod.values.map((period) {
          return SimpleDialogOption(
            onPressed: () {
              ref.read(settingsProvider.notifier).setRetentionPolicy(
                    RetentionPolicy(period: period),
                  );
              Navigator.of(ctx).pop();
            },
            child: Text(period.label),
          );
        }).toList(),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
