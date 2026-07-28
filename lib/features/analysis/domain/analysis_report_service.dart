import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

import 'analysis_report.dart';

/// Callback type for reading a stored value.
typedef StorageReadFn = Future<String?> Function(String key);

/// Callback type for writing a stored value.
typedef StorageWriteFn = Future<void> Function(String key, String value);

/// Callback type for deleting a stored value.
typedef StorageDeleteFn = Future<void> Function(String key);

/// Service for storing and retrieving user-submitted analysis reports.
///
/// Reports are stored locally in secure storage. No network submission
/// is performed — the reports remain on-device for the user's privacy.
class AnalysisReportService {
  final StorageReadFn _read;
  final StorageWriteFn _write;
  final StorageDeleteFn _delete;
  final Uuid _uuid;

  static const _storageKey = 'qriora_analysis_reports';

  AnalysisReportService._({
    required StorageReadFn read,
    required StorageWriteFn write,
    required StorageDeleteFn delete,
    Uuid? uuid,
  })  : _read = read,
        _write = write,
        _delete = delete,
        _uuid = uuid ?? const Uuid();

  factory AnalysisReportService({
    FlutterSecureStorage? storage,
    Uuid? uuid,
  }) {
    final s = storage ?? const FlutterSecureStorage();
    return AnalysisReportService._(
      read: (key) => s.read(key: key),
      write: (key, value) => s.write(key: key, value: value),
      delete: (key) => s.delete(key: key),
      uuid: uuid,
    );
  }

  /// Creates an AnalysisReportService with custom storage callbacks.
  /// Useful for testing with in-memory storage.
  factory AnalysisReportService.withStorage({
    required StorageReadFn read,
    required StorageWriteFn write,
    required StorageDeleteFn delete,
    Uuid? uuid,
  }) {
    return AnalysisReportService._(
      read: read,
      write: write,
      delete: delete,
      uuid: uuid,
    );
  }

  /// Submits a new report and stores it locally.
  Future<AnalysisReport> submitReport({
    required String scanId,
    required String ruleId,
    required int findingIndex,
    required AnalysisReportCategory category,
    String? comment,
    required String analysisVersion,
  }) async {
    final report = AnalysisReport(
      id: _uuid.v4(),
      scanId: scanId,
      ruleId: ruleId,
      findingIndex: findingIndex,
      category: category,
      comment: comment,
      submittedAt: DateTime.now(),
      analysisVersion: analysisVersion,
    );

    final reports = await _loadReports();
    reports.add(report);
    await _saveReports(reports);

    return report;
  }

  /// Retrieves all stored reports.
  Future<List<AnalysisReport>> getAllReports() async {
    return _loadReports();
  }

  /// Retrieves reports for a specific scan.
  Future<List<AnalysisReport>> getReportsForScan(String scanId) async {
    final reports = await _loadReports();
    return reports.where((r) => r.scanId == scanId).toList();
  }

  /// Checks if a report already exists for a specific finding.
  Future<bool> hasReportForFinding(String scanId, int findingIndex) async {
    final reports = await _loadReports();
    return reports.any(
      (r) => r.scanId == scanId && r.findingIndex == findingIndex,
    );
  }

  /// Deletes all stored reports.
  Future<void> deleteAllReports() async {
    await _delete(_storageKey);
  }

  Future<List<AnalysisReport>> _loadReports() async {
    final json = await _read(_storageKey);
    if (json == null) return [];
    try {
      final list = jsonDecode(json) as List<dynamic>;
      return list
          .map((e) => AnalysisReport.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> _saveReports(List<AnalysisReport> reports) async {
    final json = jsonEncode(reports.map((r) => r.toJson()).toList());
    await _write(_storageKey, json);
  }
}
