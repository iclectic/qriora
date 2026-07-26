import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// About screen — shows app information.
class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  PackageInfo? _packageInfo;

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted) setState(() => _packageInfo = info);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Qriora')),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          Icon(
            Icons.qr_code_scanner,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Center(
            child: Text('Qriora', style: Theme.of(context).textTheme.headlineSmall),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text('Know before you open.', style: Theme.of(context).textTheme.bodyMedium),
          ),
          const SizedBox(height: 24),
          if (_packageInfo != null) ...[
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Version'),
              trailing: Text('${_packageInfo!.version}+${_packageInfo!.buildNumber}'),
            ),
          ],
          const Divider(),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy'),
            subtitle: const Text('All analysis is performed on-device'),
          ),
          ListTile(
            leading: const Icon(Icons.security_outlined),
            title: const Text('Security'),
            subtitle: const Text('Deterministic rules, no AI authority'),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Qriora does not claim that any content is completely safe. '
              'The absence of warnings means only that no known risk '
              'indicator was detected — not that the content is safe.',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
