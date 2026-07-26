import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/scan_source.dart';
import '../domain/scan_record.dart';
import '../../settings/domain/retention_policy.dart';
import '../../../core/services/providers.dart';
import 'scanner_screen.dart';

/// Manual entry screen — allows the user to type or paste a value
/// to be analysed without scanning a code.
class ManualEntryScreen extends ConsumerStatefulWidget {
  const ManualEntryScreen({super.key});

  @override
  ConsumerState<ManualEntryScreen> createState() => _ManualEntryScreenState();
}

class _ManualEntryScreenState extends ConsumerState<ManualEntryScreen> {
  final _controller = TextEditingController();
  bool _hasInput = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual entry'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter or paste the content you want to analyse.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'e.g. https://example.com or WIFI:T:WPA;S:network;P:password;;',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() => _hasInput = value.trim().isNotEmpty);
              },
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _hasInput ? _analyse : null,
              icon: const Icon(Icons.search),
              label: const Text('Analyse'),
            ),
          ],
        ),
      ),
    );
  }

  void _analyse() {
    final value = _controller.text.trim();
    if (value.isEmpty) return;

    final pipeline = ref.read(scanPipelineProvider);
    final record = pipeline.process(
      value,
      source: ScanSource.manualEntry,
    );

    ref.read(lastScanResultProvider.notifier).state = record;

    // Persist if allowed
    _maybePersist(record);

    context.pushReplacement('/result/${record.id}');
  }

  Future<void> _maybePersist(ScanRecord record) async {
    final settings = ref.read(settingsProvider);
    if (settings.privateMode || !settings.saveHistory) return;
    if (settings.retentionPolicy.period == RetentionPeriod.never) return;

    // Defer persistence — the result screen can handle it
    // For now, we skip DB persistence for manual entries in this screen
    // and rely on the scan result flow.
  }
}
