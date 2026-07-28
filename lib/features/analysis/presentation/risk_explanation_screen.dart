import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../scanner/presentation/scanner_screen.dart';
import '../../analysis/domain/risk_finding.dart';
import '../../analysis/domain/risk_severity.dart';
import '../../analysis/domain/analysis_method.dart';
import '../../analysis/domain/analysis_report.dart';
import '../../analysis/domain/analysis_report_service.dart';
import '../../../core/services/providers.dart';
import '../../../app/theme/design_tokens.dart';

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
        title: const Text('Risk insight'),
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
            const SizedBox(height: 24),
            _ReportSection(
              finding: finding,
              findingIndex: findingIndex,
              scanId: scanId,
            ),
          ],
        ),
      ),
    );
  }
}

class _SeverityHeader extends StatelessWidget {
  final RiskFinding finding;

  const _SeverityHeader({required this.finding});

  Color _severityColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    switch (finding.severity) {
      case RiskSeverity.informational:
        return scheme.primary;
      case RiskSeverity.caution:
        return Colors.amber.shade700;
      case RiskSeverity.highRisk:
        return scheme.error;
      case RiskSeverity.unableToDetermine:
        return scheme.outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _severityColor(context);
    return Card(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: color, width: 4),
          ),
          borderRadius: BorderRadius.circular(QrioraDesignTokens.radiusMd),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(riskSeverityIcon(finding.severity), size: 40, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    finding.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(QrioraDesignTokens.radiusSm),
                    ),
                    child: Text(
                      finding.severity.label,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
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

/// Section for reporting incorrect analysis.
class _ReportSection extends ConsumerStatefulWidget {
  final RiskFinding finding;
  final int findingIndex;
  final String scanId;

  const _ReportSection({
    required this.finding,
    required this.findingIndex,
    required this.scanId,
  });

  @override
  ConsumerState<_ReportSection> createState() => _ReportSectionState();
}

class _ReportSectionState extends ConsumerState<_ReportSection> {
  bool _hasReported = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _checkExistingReport();
  }

  Future<void> _checkExistingReport() async {
    final service = ref.read(analysisReportServiceProvider);
    final exists = await service.hasReportForFinding(
      widget.scanId,
      widget.findingIndex,
    );
    if (mounted) setState(() => _hasReported = exists);
  }

  void _showReportDialog() {
    AnalysisReportCategory? selectedCategory;
    final commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Report incorrect analysis'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Help improve Qriora by telling us what is wrong with this finding.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                Text('Issue type', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 8),
                ...AnalysisReportCategory.values.map((cat) {
                  return RadioListTile<AnalysisReportCategory>(
                    title: Text(cat.label),
                    value: cat,
                    groupValue: selectedCategory,
                    onChanged: (v) => setDialogState(() => selectedCategory = v),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  );
                }),
                const SizedBox(height: 8),
                Text('Additional comments (optional)',
                    style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 8),
                TextField(
                  controller: commentController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Describe the issue...',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: selectedCategory == null || _isSubmitting
                  ? null
                  : () async {
                      setDialogState(() => _isSubmitting = true);
                      final service = ref.read(analysisReportServiceProvider);
                      await service.submitReport(
                        scanId: widget.scanId,
                        ruleId: widget.finding.ruleId,
                        findingIndex: widget.findingIndex,
                        category: selectedCategory!,
                        comment: commentController.text.trim().isNotEmpty
                            ? commentController.text.trim()
                            : null,
                        analysisVersion: widget.finding.ruleVersion,
                      );
                      if (ctx.mounted) Navigator.of(ctx).pop();
                      if (mounted) {
                        setState(() {
                          _hasReported = true;
                          _isSubmitting = false;
                        });
                      }
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Report submitted. Thank you for your feedback.'),
                          ),
                        );
                      }
                    },
              child: _isSubmitting
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_hasReported) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(Icons.check_circle_outline,
                  color: Theme.of(context).colorScheme.primary, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Report submitted',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      'You have already reported an issue with this finding. Thank you for your feedback.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.feedback_outlined,
                    color: Theme.of(context).colorScheme.outline, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Is this analysis incorrect?',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'If this warning is wrong or confusing, let us know. '
              'Your report is stored locally and helps improve the analysis rules.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: _showReportDialog,
                icon: const Icon(Icons.report_outlined, size: 18),
                label: const Text('Report incorrect analysis'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
