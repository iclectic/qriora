import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/services/providers.dart';

/// Export screen — allows exporting and importing scan data.
class ExportScreen extends ConsumerWidget {
  const ExportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Export & import')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.file_download_outlined),
              title: const Text('Export scan history'),
              subtitle: const Text('Export your scans as a text file'),
              onTap: () => _exportData(context, ref),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.delete_forever_outlined),
              title: const Text('Delete all data'),
              subtitle: const Text('Permanently delete all scan history'),
              onTap: () => _confirmDelete(context, ref),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _exportData(BuildContext context, WidgetRef ref) async {
    final db = ref.read(databaseProvider);
    final records = await db.getAllScanRecords();

    if (records.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No scans to export')),
        );
      }
      return;
    }

    final buffer = StringBuffer();
    buffer.writeln('Qriora scan history export');
    buffer.writeln('Exported: ${DateTime.now().toIso8601String()}');
    buffer.writeln('Records: ${records.length}');
    buffer.writeln('---');

    for (final record in records) {
      buffer.writeln('Date: ${record.scannedAt.toIso8601String()}');
      buffer.writeln('Type: ${record.contentType}');
      buffer.writeln('Value: ${record.normalisedValue}');
      if (record.note != null) {
        buffer.writeln('Note: ${record.note}');
      }
      buffer.writeln('---');
    }

    Share.share(buffer.toString(), subject: 'Qriora scan history export');
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete all data'),
        content: const Text(
          'This will permanently delete all scan history, including favourites. '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              await ref.read(databaseProvider).deleteAllScanRecords();
              if (context.mounted) {
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All data deleted')),
                );
              }
            },
            child: const Text('Delete all'),
          ),
        ],
      ),
    );
  }
}
