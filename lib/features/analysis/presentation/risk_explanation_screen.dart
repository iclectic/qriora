import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../scanner/presentation/scanner_screen.dart';
import '../../analysis/domain/risk_finding.dart';
import '../../analysis/domain/risk_severity.dart';
import '../../analysis/domain/analysis_method.dart';

/// Risk explanation screen — shows detailed information about a
/// single risk finding.
class RiskExplanationScreen extends ConsumerWidget {
  final String scanId;
  final int findingIndex;

  const RiskExplanationScreen({
    super.key,
    required this.scanId,
    required this.findingIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastScan = ref.watch(lastScanResultProvider);
    final record = (lastScan?.id == scanId) ? lastScan : null;

    if (record == null || findingIndex >= record.analysis.findings.length) {
      return Scaffold(
        appBar: AppBar(title: const Text('Risk explanation')),
        body: const Center(child: Text('Finding not found.')),
      );
    }

    final finding = record.analysis.findings[findingIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Risk explanation'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SeverityHeader(finding: finding),
            const SizedBox(height: 16),
            _ExplanationCard(finding: finding),
            const SizedBox(height: 16),
            _EvidenceCard(finding: finding),
            const SizedBox(height: 16),
            _RecommendationCard(finding: finding),
            const SizedBox(height: 16),
            _MethodCard(finding: finding),
          ],
        ),
      ),
    );
  }
}

class _SeverityHeader extends StatelessWidget {
  final RiskFinding finding;

  const _SeverityHeader({required this.finding});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(riskSeverityIcon(finding.severity), size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    finding.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    finding.severity.label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExplanationCard extends StatelessWidget {
  final RiskFinding finding;

  const _ExplanationCard({required this.finding});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Why this warning was shown', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(finding.explanation, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _EvidenceCard extends StatelessWidget {
  final RiskFinding finding;

  const _EvidenceCard({required this.finding});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Evidence', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                finding.evidence,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: 'monospace',
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  final RiskFinding finding;

  const _RecommendationCard({required this.finding});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recommended response', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(finding.recommendedResponse, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _MethodCard extends StatelessWidget {
  final RiskFinding finding;

  const _MethodCard({required this.finding});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Analysis details', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            _DetailRow(label: 'Method', value: finding.analysisMethod.label),
            _DetailRow(label: 'Rule ID', value: finding.ruleId),
            _DetailRow(label: 'Rule version', value: finding.ruleVersion),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          Text(value, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
