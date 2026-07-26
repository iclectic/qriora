import 'package:flutter/material.dart';

/// Feedback screen — allows users to provide feedback.
class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feedback')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Help improve Qriora',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            'Qriora is an open, privacy-first project. Your feedback helps '
            'improve the analysis rules and user experience.',
          ),
          const SizedBox(height: 24),
          Card(
            child: ListTile(
              leading: const Icon(Icons.bug_report_outlined),
              title: const Text('Report a bug'),
              subtitle: const Text('Report an issue with scanning or analysis'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Bug reporting will be available in a future release')),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.lightbulb_outline),
              title: const Text('Suggest a feature'),
              subtitle: const Text('Suggest a new feature or improvement'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Feature suggestions will be available in a future release')),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.rule),
              title: const Text('Report a false positive'),
              subtitle: const Text('Tell us about a warning that was incorrect'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('False positive reporting will be available in a future release')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
