import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../features/scanner/domain/scan_content_type.dart';
import '../../features/scanner/domain/scan_source.dart';
import '../../features/scanner/domain/barcode_format.dart';
import '../../features/analysis/domain/risk_severity.dart';
import '../../features/analysis/domain/analysis_method.dart';

part 'qriora_database.g.dart';

/// Drift table for scan records.
class ScanRecords extends Table {
  TextColumn get id => text()();
  TextColumn get rawValue => text()();
  TextColumn get normalisedValue => text()();
  TextColumn get contentType => text()();
  TextColumn get barcodeFormat => text()();
  TextColumn get source => text()();
  DateTimeColumn get scannedAt => dateTime()();
  TextColumn get analysisJson => text()();
  BoolColumn get isFavourite => boolean().withDefault(const Constant(false))();
  TextColumn get note => text().nullable()();
  BoolColumn get isSensitive => boolean().withDefault(const Constant(false))();
  TextColumn get analysisVersion => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [ScanRecords])
class QrioraDatabase extends _$QrioraDatabase {
  QrioraDatabase() : super(_openConnection());

  QrioraDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createIndex(
              Index('idx_scan_records_normalised_value',
                  'CREATE INDEX idx_scan_records_normalised_value ON scan_records (normalised_value)'),
            );
          }
        },
      );

  /// Inserts a scan record.
  Future<void> insertScanRecord(ScanRecordsCompanion companion) =>
      into(scanRecords).insert(companion);

  /// Gets all scan records ordered by date descending.
  Future<List<ScanRecord>> getAllScanRecords() =>
      (select(scanRecords)..orderBy([(t) => OrderingTerm.desc(t.scannedAt)]))
          .get();

  /// Gets all favourite scan records.
  Future<List<ScanRecord>> getFavouriteScanRecords() =>
      (select(scanRecords)
            ..where((t) => t.isFavourite.equals(true))
            ..orderBy([(t) => OrderingTerm.desc(t.scannedAt)]))
          .get();

  /// Gets a single scan record by ID.
  Future<ScanRecord?> getScanRecordById(String id) =>
      (select(scanRecords)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Updates the favourite status of a scan record.
  Future<void> updateFavourite(String id, bool isFavourite) =>
      (update(scanRecords)..where((t) => t.id.equals(id)))
          .write(ScanRecordsCompanion(isFavourite: Value(isFavourite)));

  /// Updates the note on a scan record.
  Future<void> updateNote(String id, String? note) =>
      (update(scanRecords)..where((t) => t.id.equals(id)))
          .write(ScanRecordsCompanion(note: Value(note)));

  /// Deletes a scan record by ID.
  Future<int> deleteScanRecord(String id) =>
      (delete(scanRecords)..where((t) => t.id.equals(id))).go();

  /// Deletes all scan records.
  Future<int> deleteAllScanRecords() => delete(scanRecords).go();

  /// Deletes scan records older than the given date.
  Future<int> deleteRecordsOlderThan(DateTime cutoff) =>
      (delete(scanRecords)..where((t) => t.scannedAt.isSmallerThanValue(cutoff)))
          .go();

  /// Watches all scan records as a stream.
  Stream<List<ScanRecord>> watchAllScanRecords() =>
      (select(scanRecords)..orderBy([(t) => OrderingTerm.desc(t.scannedAt)]))
          .watch();

  /// Watches scan records filtered by a search query.
  Stream<List<ScanRecord>> watchSearchScanRecords(String query) {
    final likePattern = '%$query%';
    return (select(scanRecords)
          ..where((t) => t.normalisedValue.like(likePattern))
          ..orderBy([(t) => OrderingTerm.desc(t.scannedAt)]))
        .watch();
  }

  /// Watches scan records filtered by content type.
  Stream<List<ScanRecord>> watchScanRecordsByType(String contentType) =>
      (select(scanRecords)
            ..where((t) => t.contentType.equals(contentType))
            ..orderBy([(t) => OrderingTerm.desc(t.scannedAt)]))
          .watch();

  /// Watches scan records with both search and content type filter.
  Stream<List<ScanRecord>> watchFilteredScanRecords({
    String? query,
    String? contentType,
  }) {
    final q = select(scanRecords)
      ..orderBy([(t) => OrderingTerm.desc(t.scannedAt)]);
    if (query != null && query.isNotEmpty) {
      q.where((t) => t.normalisedValue.like('%$query%'));
    }
    if (contentType != null && contentType.isNotEmpty) {
      q.where((t) => t.contentType.equals(contentType));
    }
    return q.watch();
  }

  /// Gets a page of scan records for paginated loading.
  Future<List<ScanRecord>> getScanRecordsPage({
    int limit = 50,
    int offset = 0,
  }) =>
      (select(scanRecords)
            ..orderBy([(t) => OrderingTerm.desc(t.scannedAt)])
            ..limit(limit, offset: offset))
          .get();

  /// Counts total scan records.
  Future<int> countScanRecords() async {
    final count = countAll();
    final query = selectOnly(scanRecords)..addColumns([count]);
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  /// Watches favourite scan records as a stream.
  Stream<List<ScanRecord>> watchFavouriteScanRecords() =>
      (select(scanRecords)
            ..where((t) => t.isFavourite.equals(true))
            ..orderBy([(t) => OrderingTerm.desc(t.scannedAt)]))
          .watch();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'qriora.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

/// Extension to convert [ScanContentType] to/from string for DB storage.
extension ScanContentTypeDb on ScanContentType {
  String get dbValue => name;
  static ScanContentType fromDb(String value) {
    return ScanContentType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ScanContentType.unknown,
    );
  }
}

/// Extension to convert [ScanSource] to/from string for DB storage.
extension ScanSourceDb on ScanSource {
  String get dbValue => name;
  static ScanSource fromDb(String value) {
    return ScanSource.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ScanSource.camera,
    );
  }
}

/// Extension to convert [BarcodeFormat] to/from string for DB storage.
extension BarcodeFormatDb on BarcodeFormat {
  String get dbValue => name;
  static BarcodeFormat fromDb(String value) {
    return BarcodeFormat.values.firstWhere(
      (e) => e.name == value,
      orElse: () => BarcodeFormat.unknown,
    );
  }
}

/// Extension to convert [RiskSeverity] to/from string for DB storage.
extension RiskSeverityDb on RiskSeverity {
  String get dbValue => name;
  static RiskSeverity fromDb(String value) {
    return RiskSeverity.values.firstWhere(
      (e) => e.name == value,
      orElse: () => RiskSeverity.informational,
    );
  }
}

/// Extension to convert [AnalysisMethod] to/from string for DB storage.
extension AnalysisMethodDb on AnalysisMethod {
  String get dbValue => name;
  static AnalysisMethod fromDb(String value) {
    return AnalysisMethod.values.firstWhere(
      (e) => e.name == value,
      orElse: () => AnalysisMethod.deterministicRule,
    );
  }
}
