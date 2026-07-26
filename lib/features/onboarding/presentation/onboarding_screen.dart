import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/providers.dart';

/// Onboarding screen — shown on first launch.
class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.qr_code_scanner,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'Qriora',
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Know before you open.',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              _OnboardingStep(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy first',
                description: 'All analysis happens on your device. No data leaves your phone unless you choose to share it.',
              ),
              const SizedBox(height: 16),
              _OnboardingStep(
                icon: Icons.shield_outlined,
                title: 'Explainable risk analysis',
                description: 'Qriora explains what a code contains, what it will do, and what you should know before proceeding.',
              ),
              const SizedBox(height: 16),
              _OnboardingStep(
                icon: Icons.check_circle_outline,
                title: 'You stay in control',
                description: 'Qriora never automatically opens links. You decide what to do after reviewing the analysis.',
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: () async {
                  await ref.read(settingsProvider.notifier).completeOnboarding();
                  if (context.mounted) {
                    context.go('/scan');
                  }
                },
                child: const Text('Get started'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () async {
                  await ref.read(settingsProvider.notifier).completeOnboarding();
                  if (context.mounted) {
                    context.go('/scan');
                  }
                },
                child: const Text('Skip'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingStep extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _OnboardingStep({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
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
    );
  }
}
