import 'package:flutter_test/flutter_test.dart';
import 'package:qriora/features/analysis/domain/analysis_report.dart';
import 'package:qriora/features/analysis/domain/analysis_report_service.dart';

void main() {
  late AnalysisReportService service;
  late Map<String, String> memoryStore;

  setUp(() {
    memoryStore = {};
    service = AnalysisReportService.withStorage(
      read: (key) async => memoryStore[key],
      write: (key, value) async => memoryStore[key] = value,
      delete: (key) async => memoryStore.remove(key),
    );
  });

  group('AnalysisReportService', () {
    test('submitReport stores a report', () async {
      final report = await service.submitReport(
        scanId: 'scan-1',
        ruleId: 'url-ip-host',
        findingIndex: 0,
        category: AnalysisReportCategory.falsePositive,
        comment: 'This is a legitimate IP',
        analysisVersion: '1.0.0',
      );

      expect(report.id, isNotEmpty);
      expect(report.scanId, 'scan-1');
      expect(report.ruleId, 'url-ip-host');
      expect(report.category, AnalysisReportCategory.falsePositive);
      expect(report.comment, 'This is a legitimate IP');

      final all = await service.getAllReports();
      expect(all.length, 1);
      expect(all.first.id, report.id);
    });

    test('hasReportForFinding returns true after submission', () async {
      await service.submitReport(
        scanId: 'scan-1',
        ruleId: 'url-ip-host',
        findingIndex: 2,
        category: AnalysisReportCategory.incorrectSeverity,
        analysisVersion: '1.0.0',
      );

      final exists = await service.hasReportForFinding('scan-1', 2);
      expect(exists, isTrue);
    });

    test('hasReportForFinding returns false when no report', () async {
      final exists = await service.hasReportForFinding('scan-1', 0);
      expect(exists, isFalse);
    });

    test('getReportsForScan filters by scanId', () async {
      await service.submitReport(
        scanId: 'scan-1',
        ruleId: 'rule-a',
        findingIndex: 0,
        category: AnalysisReportCategory.falsePositive,
        analysisVersion: '1.0.0',
      );
      await service.submitReport(
        scanId: 'scan-2',
        ruleId: 'rule-b',
        findingIndex: 0,
        category: AnalysisReportCategory.missingRisk,
        analysisVersion: '1.0.0',
      );

      final scan1Reports = await service.getReportsForScan('scan-1');
      expect(scan1Reports.length, 1);
      expect(scan1Reports.first.scanId, 'scan-1');

      final scan2Reports = await service.getReportsForScan('scan-2');
      expect(scan2Reports.length, 1);
      expect(scan2Reports.first.scanId, 'scan-2');
    });

    test('deleteAllReports clears all reports', () async {
      await service.submitReport(
        scanId: 'scan-1',
        ruleId: 'rule-a',
        findingIndex: 0,
        category: AnalysisReportCategory.falsePositive,
        analysisVersion: '1.0.0',
      );

      await service.deleteAllReports();
      final all = await service.getAllReports();
      expect(all, isEmpty);
    });

    test('AnalysisReportCategory labels are human-readable', () {
      for (final cat in AnalysisReportCategory.values) {
        expect(cat.label, isNotEmpty);
      }
    });

    test('report survives service recreation (persistence)', () async {
      await service.submitReport(
        scanId: 'scan-1',
        ruleId: 'rule-a',
        findingIndex: 0,
        category: AnalysisReportCategory.falsePositive,
        analysisVersion: '1.0.0',
      );

      final newService = AnalysisReportService.withStorage(
        read: (key) async => memoryStore[key],
        write: (key, value) async => memoryStore[key] = value,
        delete: (key) async => memoryStore.remove(key),
      );

      final all = await newService.getAllReports();
      expect(all.length, 1);
      expect(all.first.scanId, 'scan-1');
    });
  });
}
