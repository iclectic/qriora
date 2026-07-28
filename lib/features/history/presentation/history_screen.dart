import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/providers.dart';
import '../../../core/database/qriora_database.dart';
import '../../../app/theme/design_tokens.dart';
import '../../scanner/domain/scan_content_type.dart';

/// History screen — shows a list of past scans with search and filtering.
class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String? _contentTypeFilter;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);

    if (settings.privateMode) {
      return Scaffold(
        appBar: AppBar(title: const Text('History')),
        body: const _EmptyState(
          icon: Icons.lock_outline,
          title: 'Private mode is active',
          message: 'Scans are not being saved. Disable private mode in Settings to keep history.',
        ),
      );
    }

    if (!settings.saveHistory) {
      return Scaffold(
        appBar: AppBar(title: const Text('History')),
        body: const _EmptyState(
          icon: Icons.history_toggle_off,
          title: 'History is disabled',
          message: 'Enable history saving in Settings to keep your scans.',
        ),
      );
    }

    final recordsAsync = ref.watch(
      _filteredHistoryProvider((_searchQuery, _contentTypeFilter)),
    );

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              QrioraDesignTokens.spaceMd,
              QrioraDesignTokens.spaceSm,
              QrioraDesignTokens.spaceMd,
              QrioraDesignTokens.spaceSm,
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search scans...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(QrioraDesignTokens.radiusMd),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          if (_contentTypeFilter != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: QrioraDesignTokens.spaceMd),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 8,
                  children: [
                    Chip(
                      label: Text(_contentTypeFilter!),
                      onDeleted: () => setState(() => _contentTypeFilter = null),
                    ),
                  ],
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: QrioraDesignTokens.spaceMd),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: _showFilterPicker,
                icon: const Icon(Icons.filter_list, size: 18),
                label: const Text('Filter by type'),
              ),
            ),
          ),
          Expanded(
            child: recordsAsync.when(
              data: (records) {
                if (records.isEmpty) {
                  if (_searchQuery.isNotEmpty || _contentTypeFilter != null) {
                    return const _EmptyState(
                      icon: Icons.search_off,
                      title: 'No matching scans',
                      message: 'Try a different search term or filter.',
                    );
                  }
                  return const _EmptyState(
                    icon: Icons.history,
                    title: 'No scans yet',
                    message: 'Scan a code to see it here.',
                  );
                }
                return ListView.builder(
                  itemCount: records.length,
                  itemBuilder: (context, index) {
                    final record = records[index];
                    final contentType = ScanContentTypeDb.fromDb(record.contentType);
                    return ListTile(
                      leading: Icon(contentType.icon),
                      title: Text(
                        record.normalisedValue,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
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
              error: (error, stack) => _EmptyState(
                icon: Icons.error_outline,
                title: 'Something went wrong',
                message: 'Error: $error',
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  void _showFilterPicker() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(QrioraDesignTokens.spaceMd),
              child: Text(
                'Filter by content type',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            ...ScanContentType.values.where((t) => t != ScanContentType.unknown && t != ScanContentType.malformed).map((type) {
              return ListTile(
                leading: Icon(type.icon),
                title: Text(type.label),
                onTap: () {
                  setState(() => _contentTypeFilter = type.label);
                  Navigator.of(ctx).pop();
                },
              );
            }),
          ],
        ),
      ),
    );
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

/// Reusable empty state widget.
class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;

  const _EmptyState({
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(QrioraDesignTokens.spaceLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Theme.of(context).colorScheme.outline),
            const SizedBox(height: QrioraDesignTokens.spaceMd),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: QrioraDesignTokens.spaceSm),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

/// Provider for filtered history records.
final _filteredHistoryProvider = StreamProvider.family
    .autoDispose<List<ScanRecord>, (String, String?)>((ref, params) {
  final db = ref.watch(databaseProvider);
  final (query, contentTypeFilter) = params;

  String? contentTypeDb;
  if (contentTypeFilter != null) {
    try {
      final type = ScanContentType.values.firstWhere(
        (e) => e.label == contentTypeFilter,
      );
      contentTypeDb = type.dbValue;
    } catch (_) {}
  }

  return db.watchFilteredScanRecords(
    query: query.isNotEmpty ? query : null,
    contentType: contentTypeDb,
  );
});
