import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/providers.dart';
import '../../../core/database/qriora_database.dart';

/// History screen — shows a list of past scans.
class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    if (settings.privateMode) {
      return Scaffold(
        appBar: AppBar(title: const Text('History')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline, size: 48),
                SizedBox(height: 16),
                Text('Private mode is active'),
                SizedBox(height: 8),
                Text(
                  'Scans are not being saved. Disable private mode in Settings to keep history.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (!settings.saveHistory) {
      return Scaffold(
        appBar: AppBar(title: const Text('History')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history_toggle_off, size: 48),
                SizedBox(height: 16),
                Text('History is disabled'),
                SizedBox(height: 8),
                Text(
                  'Enable history saving in Settings to keep your scans.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    final recordsAsync = ref.watch(_historyRecordsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_outlined),
            tooltip: 'Clear history',
            onPressed: () => _confirmClear(context, ref),
          ),
        ],
      ),
      body: recordsAsync.when(
        data: (records) {
          if (records.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 48),
                  SizedBox(height: 16),
                  Text('No scans yet'),
                  SizedBox(height: 8),
                  Text('Scan a code to see it here.'),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              final contentType = ScanContentTypeDb.fromDb(record.contentType);
              return ListTile(
                leading: Icon(contentType.icon),
                title: Text(record.normalisedValue, maxLines: 1, overflow: TextOverflow.ellipsis),
                subtitle: Text(
                  '${contentType.label} • ${_formatDate(record.scannedAt)}',
                ),
                trailing: record.isFavourite
                    ? const Icon(Icons.star, size: 16)
                    : null,
                onTap: () => context.push('/result/${record.id}'),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  void _confirmClear(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear history'),
        content: const Text('Are you sure you want to delete all scan history? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              await ref.read(databaseProvider).deleteAllScanRecords();
              if (context.mounted) Navigator.of(ctx).pop();
            },
            child: const Text('Clear all'),
          ),
        ],
      ),
    );
  }
}

final _historyRecordsProvider = StreamProvider<List<ScanRecord>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllScanRecords();
});
