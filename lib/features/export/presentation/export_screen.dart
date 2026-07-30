import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/database/qriora_database.dart';
import '../../../core/services/providers.dart';

/// Export screen — allows encrypted export and import of scan data.
class ExportScreen extends ConsumerStatefulWidget {
  const ExportScreen({super.key});

  @override
  ConsumerState<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends ConsumerState<ExportScreen> {
  final _exportPasswordController = TextEditingController();
  final _importPasswordController = TextEditingController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _exportPasswordController.dispose();
    _importPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Export & import')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ExportCard(
            passwordController: _exportPasswordController,
            isProcessing: _isProcessing,
            onExport: _exportData,
          ),
          const SizedBox(height: 16),
          _ImportCard(
            passwordController: _importPasswordController,
            isProcessing: _isProcessing,
            onImport: _importData,
          ),
          const SizedBox(height: 16),
          _DeleteCard(onDelete: _confirmDelete),
        ],
      ),
    );
  }

  Future<void> _exportData() async {
    final password = _exportPasswordController.text.trim();
    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 6 characters.')),
      );
      return;
    }

    setState(() => _isProcessing = true);

    try {
      final db = ref.read(databaseProvider);
      final exportService = ref.read(exportServiceProvider);
      final records = await db.getAllScanRecords();

      if (records.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No scans to export')),
          );
        }
        return;
      }

      final recordMaps = records.map(_recordToJson).toList();
      final result = await exportService.exportRecords(recordMaps, password);

      if (result.success && result.data != null) {
        final tempDir = await getTemporaryDirectory();
        final file = File(
          '${tempDir.path}/qriora_export_${DateTime.now().millisecondsSinceEpoch}.qriora',
        );
        await file.writeAsBytes(result.data!);

        if (mounted) {
          await Share.shareXFiles(
            [XFile(file.path)],
            subject: 'Qriora encrypted export (${result.recordCount} records)',
          );
        }
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.errorMessage ?? 'Export failed')),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Future<void> _importData() async {
    final password = _importPasswordController.text.trim();
    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter the password for the import file.')),
      );
      return;
    }

    setState(() => _isProcessing = true);

    try {
      final clipboardData = await Clipboard.getData('text/plain');
      if (clipboardData?.text == null || clipboardData!.text!.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Copy the export file content to clipboard first.'),
            ),
          );
        }
        return;
      }

      final data = Uint8List.fromList(utf8.encode(clipboardData.text!));
      final exportService = ref.read(exportServiceProvider);

      if (!exportService.isValidExportFormat(data)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid file format. Not a Qriora export.')),
          );
        }
        return;
      }

      final result = await exportService.importRecords(data, password);

      if (result.success) {
        final db = ref.read(databaseProvider);
        var imported = 0;
        for (final recordMap in result.records) {
          try {
            final companion = _jsonToCompanion(recordMap);
            await db.insertScanRecord(companion);
            imported++;
          } catch (_) {
            // Skip duplicates or invalid records
          }
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Imported $imported of ${result.recordCount} records')),
          );
        }
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.errorMessage ?? 'Import failed')),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  void _confirmDelete() {
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
              if (ctx.mounted) {
                Navigator.of(ctx).pop();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All data deleted')),
                  );
                }
              }
            },
            child: const Text('Delete all'),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _recordToJson(ScanRecord r) {
    return {
      'id': r.id,
      'rawValue': r.rawValue,
      'normalisedValue': r.normalisedValue,
      'contentType': r.contentType,
      'barcodeFormat': r.barcodeFormat,
      'source': r.source,
      'scannedAt': r.scannedAt.toIso8601String(),
      'analysisJson': r.analysisJson,
      'isFavourite': r.isFavourite,
      'note': r.note,
      'isSensitive': r.isSensitive,
      'analysisVersion': r.analysisVersion,
    };
  }

  ScanRecordsCompanion _jsonToCompanion(Map<String, dynamic> json) {
    return ScanRecordsCompanion.insert(
      id: json['id'] as String,
      rawValue: json['rawValue'] as String,
      normalisedValue: json['normalisedValue'] as String,
      contentType: json['contentType'] as String,
      barcodeFormat: json['barcodeFormat'] as String,
      source: json['source'] as String,
      scannedAt: DateTime.parse(json['scannedAt'] as String),
      analysisJson: json['analysisJson'] as String,
      isFavourite: Value(json['isFavourite'] as bool? ?? false),
      note: Value(json['note'] as String?),
      isSensitive: Value(json['isSensitive'] as bool? ?? false),
      analysisVersion: json['analysisVersion'] as String,
    );
  }
}

class _ExportCard extends StatelessWidget {
  final TextEditingController passwordController;
  final bool isProcessing;
  final VoidCallback onExport;

  const _ExportCard({
    required this.passwordController,
    required this.isProcessing,
    required this.onExport,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.lock_outline, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Encrypted export',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Export your scan history as an encrypted file. '
              'The file is protected with AES-256 encryption. '
              'Keep your password safe — it cannot be recovered.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Encryption password',
                border: OutlineInputBorder(),
                hintText: 'At least 6 characters',
                prefixIcon: Icon(Icons.password),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: isProcessing ? null : onExport,
                icon: isProcessing
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.file_download_outlined, size: 18),
                label: const Text('Export'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImportCard extends StatelessWidget {
  final TextEditingController passwordController;
  final bool isProcessing;
  final VoidCallback onImport;

  const _ImportCard({
    required this.passwordController,
    required this.isProcessing,
    required this.onImport,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.lock_open_outlined, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Import encrypted file',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Import scan records from an encrypted Qriora export file. '
              'Copy the file content to your clipboard, then enter the password.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Decryption password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.password),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.tonalIcon(
                onPressed: isProcessing ? null : onImport,
                icon: isProcessing
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.file_upload_outlined, size: 18),
                label: const Text('Import from clipboard'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeleteCard extends StatelessWidget {
  final VoidCallback onDelete;

  const _DeleteCard({required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.delete_forever_outlined, color: Colors.red),
        title: const Text('Delete all data'),
        subtitle: const Text('Permanently delete all scan history'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onDelete,
      ),
    );
  }
}
