import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/providers.dart';
import '../../../core/database/qriora_database.dart';

/// Favourites screen — shows scans the user has starred.
class FavouritesScreen extends ConsumerWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordsAsync = ref.watch(_favouriteRecordsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Favourites')),
      body: recordsAsync.when(
        data: (records) {
          if (records.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star_border, size: 48),
                  SizedBox(height: 16),
                  Text('No favourites yet'),
                  SizedBox(height: 8),
                  Text('Star a scan to save it here.'),
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
                subtitle: Text(contentType.label),
                trailing: const Icon(Icons.star, color: Colors.amber, size: 20),
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
}

final _favouriteRecordsProvider = StreamProvider<List<ScanRecord>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchFavouriteScanRecords();
});
