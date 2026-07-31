import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../scanner/domain/scan_record.dart';
import '../../scanner/presentation/scanner_screen.dart';
import '../../analysis/domain/risk_severity.dart';
import '../../analysis/domain/risk_finding.dart';
import '../../analysis/domain/suggested_action.dart';
import '../../analysis/domain/extracted_entity.dart';
import '../../analysis/domain/action_executor.dart';
import '../../analysis/domain/deep_link_allowlist.dart';
import '../../../core/services/providers.dart';
import '../../../core/services/qriora_logger.dart';
import '../../../core/services/screenshot_protection_service.dart';

/// Scan result screen — displays the safe preview, risk findings,
/// and suggested actions for the user to choose from.
class ScanResultScreen extends ConsumerStatefulWidget {
  final String scanId;

  const ScanResultScreen({super.key, required this.scanId});

  @override
  ConsumerState<ScanResultScreen> createState() => _ScanResultScreenState();
}

class _ScanResultScreenState extends ConsumerState<ScanResultScreen> {
  late final ScreenshotProtectionService _screenshotProtection;

  @override
  void initState() {
    super.initState();
    _screenshotProtection = ref.read(screenshotProtectionProvider);
    // Enable screenshot protection on sensitive screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenshotProtection.enable();
    });
  }

  @override
  void dispose() {
    // Disable screenshot protection when leaving
    _screenshotProtection.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Try to get the record from the in-memory provider first
    final lastScan = ref.watch(lastScanResultProvider);
    final record = (lastScan?.id == widget.scanId) ? lastScan : null;

    if (record == null) {
      // TODO: Load from database
      return Scaffold(
        appBar: AppBar(title: const Text('Scan result')),
        body: const Center(child: Text('Scan record not found.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan result'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/scan'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.code),
            tooltip: 'View raw content',
            onPressed: () => context.push('/result/${widget.scanId}/raw'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ContentPreviewCard(record: record),
            const SizedBox(height: 16),
            _RiskSummaryCard(record: record),
            const SizedBox(height: 16),
            _ExtractedEntitiesCard(record: record),
            const SizedBox(height: 16),
            _ActionsCard(record: record),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

/// Card showing the content type and normalised value.
class _ContentPreviewCard extends ConsumerWidget {
  final ScanRecord record;

  const _ContentPreviewCard({required this.record});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentType = record.payload.contentType;
    final settings = ref.read(settingsProvider);
    final shouldMask = settings.maskSensitiveValues && record.isSensitive;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(contentType.icon, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contentType.label,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        contentType.description,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Text(
              'Content',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 4),
            SelectableText(
              shouldMask
                  ? _maskValue(record.payload.normalisedValue)
                  : record.payload.normalisedValue,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (shouldMask) ...[
              const SizedBox(height: 8),
              Text(
                'Sensitive content is masked. Tap to reveal in raw view.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _maskValue(String value) {
    if (value.length <= 6) return '••••';
    return '${value.substring(0, 3)}••••${value.substring(value.length - 3)}';
  }
}

/// Card showing the overall risk severity and individual findings.
class _RiskSummaryCard extends StatelessWidget {
  final ScanRecord record;

  const _RiskSummaryCard({required this.record});

  @override
  Widget build(BuildContext context) {
    final severity = record.analysis.overallSeverity;
    final findings = record.analysis.findings;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(riskSeverityIcon(severity), size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        severity.label,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        record.analysis.summary,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (findings.isNotEmpty) ...[
              const Divider(height: 24),
              Text(
                'Findings (${findings.length})',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 8),
              ...findings.asMap().entries.map((entry) {
                final index = entry.key;
                final finding = entry.value;
                return _FindingTile(
                  finding: finding,
                  onTap: () => context.push('/result/${record.id}/risk/$index'),
                );
              }),
            ],
            const Divider(height: 24),
            Text(
              'Limitations',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 4),
            ...record.analysis.limitations.map((l) => Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

/// A single risk finding tile.
class _FindingTile extends StatelessWidget {
  final RiskFinding finding;
  final VoidCallback onTap;

  const _FindingTile({required this.finding, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(riskSeverityIcon(finding.severity), size: 20),
      title: Text(finding.title),
      subtitle: Text(
        finding.severity.label,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

/// Card showing extracted entities from the payload.
class _ExtractedEntitiesCard extends ConsumerWidget {
  final ScanRecord record;

  const _ExtractedEntitiesCard({required this.record});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entities = record.payload.entities;
    if (entities.isEmpty) return const SizedBox.shrink();

    final settings = ref.read(settingsProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Extracted information',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            ...entities.map((entity) {
              final shouldMask = settings.maskSensitiveValues && entity.isSensitive;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        entity.type.label,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: SelectableText(
                        shouldMask
                            ? '••••••••'
                            : entity.value,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

/// Card showing the suggested actions the user can take.
class _ActionsCard extends ConsumerWidget {
  final ScanRecord record;

  const _ActionsCard({required this.record});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = ref.read(scanPipelineProvider).resolve(record.payload);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What would you like to do?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: actions.map((action) {
                if (action.isPrimary) {
                  return FilledButton.icon(
                    onPressed: () => _handleAction(context, ref, action, record),
                    icon: Icon(action.type.icon),
                    label: Text(action.label),
                  );
                }
                return OutlinedButton.icon(
                  onPressed: () => _handleAction(context, ref, action, record),
                  icon: Icon(action.type.icon),
                  label: Text(action.label),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _handleAction(
    BuildContext context,
    WidgetRef ref,
    SuggestedAction action,
    ScanRecord record,
  ) {
    final executor = ActionExecutor();

    switch (action.type) {
      case SuggestedActionType.openUrl:
        _confirmAndExecute(
          context,
          title: 'Open link',
          action: action,
          record: record,
          onExecute: () => executor.openUrl(action.actionValue!),
        );
        break;
      case SuggestedActionType.copy:
        _execute(
          context,
          () => executor.copy(action.actionValue ?? record.payload.normalisedValue),
        );
        break;
      case SuggestedActionType.share:
        _execute(
          context,
          () => executor.share(action.actionValue ?? record.payload.normalisedValue),
        );
        break;
      case SuggestedActionType.saveFavourite:
        _toggleFavourite(context, ref, record);
        break;
      case SuggestedActionType.dismiss:
        context.go('/scan');
        break;
      case SuggestedActionType.rescan:
        context.go('/scan');
        break;
      case SuggestedActionType.joinWifi:
        _confirmAndExecute(
          context,
          title: 'Join Wi-Fi',
          action: action,
          record: record,
          onExecute: () async => const ActionFailure(
            'Wi-Fi joining requires platform integration',
          ),
        );
        break;
      case SuggestedActionType.callPhone:
        _confirmAndExecute(
          context,
          title: 'Call number',
          action: action,
          record: record,
          onExecute: () => executor.callPhone(action.actionValue!),
        );
        break;
      case SuggestedActionType.sendSms:
        _confirmAndExecute(
          context,
          title: 'Send SMS',
          action: action,
          record: record,
          onExecute: () => executor.sendSms(action.actionValue!),
        );
        break;
      case SuggestedActionType.composeEmail:
        _confirmAndExecute(
          context,
          title: 'Compose email',
          action: action,
          record: record,
          onExecute: () => executor.composeEmail(action.actionValue ?? ''),
        );
        break;
      case SuggestedActionType.saveContact:
        _confirmAndExecute(
          context,
          title: 'Save contact',
          action: action,
          record: record,
          onExecute: () async => const ActionFailure(
            'Contact saving requires platform integration',
          ),
        );
        break;
      case SuggestedActionType.addCalendarEvent:
        _confirmAndExecute(
          context,
          title: 'Add calendar event',
          action: action,
          record: record,
          onExecute: () async => const ActionFailure(
            'Calendar integration requires platform setup',
          ),
        );
        break;
      case SuggestedActionType.openInMap:
        _confirmAndExecute(
          context,
          title: 'Open in map',
          action: action,
          record: record,
          onExecute: () => executor.openInMap(action.actionValue!),
        );
        break;
      case SuggestedActionType.lookupProduct:
        _confirmAndExecute(
          context,
          title: 'Look up product',
          action: action,
          record: record,
          onExecute: () => executor.lookupProduct(action.actionValue!),
        );
        break;
      case SuggestedActionType.addNote:
        _showAddNoteDialog(context, ref, record);
        break;
    }
  }

  void _execute(
    BuildContext context,
    Future<ActionResult> Function() onExecute,
  ) async {
    final result = await onExecute();
    if (!context.mounted) return;
    _showResultSnack(context, result);
  }

  void _confirmAndExecute(
    BuildContext context, {
    required String title,
    required SuggestedAction action,
    required ScanRecord record,
    required Future<ActionResult> Function() onExecute,
  }) {
    final message = ActionExecutor.buildConfirmationMessage(action, record);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Text(message),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _execute(context, onExecute);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showResultSnack(BuildContext context, ActionResult result) {
    final message = switch (result) {
      ActionSuccess(:final message) => message,
      ActionCancelled() => 'Cancelled',
      ActionFailure(:final reason) => reason,
    };
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _toggleFavourite(BuildContext context, WidgetRef ref, ScanRecord record) {
    ref.read(lastScanResultProvider.notifier).state =
        record.copyWith(isFavourite: !record.isFavourite);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(record.isFavourite ? 'Removed from favourites' : 'Added to favourites'),
      ),
    );
  }

  void _showAddNoteDialog(BuildContext context, WidgetRef ref, ScanRecord record) {
    final controller = TextEditingController(text: record.note ?? '');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add note'),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Add a private note for this scan...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              ref.read(lastScanResultProvider.notifier).state =
                  record.copyWith(note: controller.text.trim().isEmpty ? null : controller.text.trim());
              Navigator.of(ctx).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
