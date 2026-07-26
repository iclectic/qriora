import 'package:flutter/material.dart';

/// Privacy screen — explains how Qriora handles data.
class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy & data')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _PrivacyCard(
            icon: Icons.phone_android,
            title: 'On-device analysis',
            description: 'All scanning, parsing, and risk analysis happens entirely on your device. '
                'No scanned content is sent to any server.',
          ),
          _PrivacyCard(
            icon: Icons.lock_outline,
            title: 'Private mode',
            description: 'When private mode is enabled, scans are never saved to the database. '
                'Your scanning activity leaves no trace on your device.',
          ),
          _PrivacyCard(
            icon: Icons.storage,
            title: 'Local storage',
            description: 'Scan history is stored in a local SQLite database on your device. '
                'You control retention and can delete all data at any time.',
          ),
          _PrivacyCard(
            icon: Icons.visibility_off_outlined,
            title: 'Sensitive data masking',
            description: 'Wi-Fi passwords and other credentials are masked by default. '
                'You must explicitly choose to reveal them.',
          ),
          _PrivacyCard(
            icon: Icons.cloud_off,
            title: 'No network lookups by default',
            description: 'Qriora does not perform any network-based security lookups unless '
                'you explicitly enable and consent to them each time.',
          ),
          _PrivacyCard(
            icon: Icons.block,
            title: 'No automatic link opening',
            description: 'Qriora never automatically opens a scanned link. You always review '
                'the content and choose whether to proceed.',
          ),
          _PrivacyCard(
            icon: Icons.no_accounts,
            title: 'No account required',
            description: 'Qriora does not require an account, login, or registration. '
                'There is no user tracking or analytics in the MVP.',
          ),
        ],
      ),
    );
  }
}

class _PrivacyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _PrivacyCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 24, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 4),
                  Text(description, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
