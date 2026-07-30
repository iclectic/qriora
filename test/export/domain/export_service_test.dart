import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:qriora/features/export/domain/export_service.dart';

void main() {
  late ExportService service;

  setUp(() {
    service = ExportService();
  });

  group('ExportService', () {
    final sampleRecords = [
      {
        'id': 'test-1',
        'rawValue': 'https://example.com',
        'normalisedValue': 'https://example.com',
        'contentType': 'httpsUrl',
        'barcodeFormat': 'qrCode',
        'source': 'camera',
        'scannedAt': '2024-01-01T10:00:00.000',
        'analysisJson': '{"findings":[]}',
        'isFavourite': false,
        'note': null,
        'isSensitive': false,
        'analysisVersion': '1.0.0',
      },
      {
        'id': 'test-2',
        'rawValue': 'WIFI:T:WPA;S:TestNet;P:pass123;;',
        'normalisedValue': 'WIFI:T:WPA;S:TestNet;P:pass123;;',
        'contentType': 'wifi',
        'barcodeFormat': 'qrCode',
        'source': 'camera',
        'scannedAt': '2024-01-02T12:00:00.000',
        'analysisJson': '{"findings":[]}',
        'isFavourite': true,
        'note': 'Home network',
        'isSensitive': true,
        'analysisVersion': '1.0.0',
      },
    ];

    test('export and import round-trip succeeds with correct password', () async {
      final exportResult = await service.exportRecords(sampleRecords, 'testpass123');
      expect(exportResult.success, isTrue);
      expect(exportResult.data, isNotNull);
      expect(exportResult.recordCount, 2);

      final importResult = await service.importRecords(
        Uint8List.fromList(exportResult.data!),
        'testpass123',
      );
      expect(importResult.success, isTrue);
      expect(importResult.recordCount, 2);
      expect(importResult.records[0]['id'], 'test-1');
      expect(importResult.records[1]['id'], 'test-2');
      expect(importResult.records[1]['note'], 'Home network');
      expect(importResult.records[1]['isSensitive'], true);
    });

    test('import fails with wrong password', () async {
      final exportResult = await service.exportRecords(sampleRecords, 'correctpass');
      expect(exportResult.success, isTrue);

      final importResult = await service.importRecords(
        Uint8List.fromList(exportResult.data!),
        'wrongpass',
      );
      expect(importResult.success, isFalse);
      expect(importResult.errorMessage, contains('Incorrect password'));
    });

    test('export fails with short password', () async {
      final result = await service.exportRecords(sampleRecords, 'short');
      expect(result.success, isFalse);
      expect(result.errorMessage, contains('at least 6 characters'));
    });

    test('isValidExportFormat returns true for valid export', () async {
      final exportResult = await service.exportRecords(sampleRecords, 'testpass123');
      final isValid = service.isValidExportFormat(
        Uint8List.fromList(exportResult.data!),
      );
      expect(isValid, isTrue);
    });

    test('isValidExportFormat returns false for random data', () {
      final randomData = Uint8List.fromList(utf8.encode('not an export file'));
      final isValid = service.isValidExportFormat(randomData);
      expect(isValid, isFalse);
    });

    test('import fails for invalid file format', () async {
      final randomData = Uint8List.fromList(utf8.encode('not an export file'));
      final result = await service.importRecords(randomData, 'somepassword');
      expect(result.success, isFalse);
      expect(result.errorMessage, contains('Invalid file format'));
    });

    test('export with empty records succeeds with zero count', () async {
      final result = await service.exportRecords([], 'testpass123');
      expect(result.success, isTrue);
      expect(result.recordCount, 0);
    });

    test('exported data contains magic header', () async {
      final result = await service.exportRecords(sampleRecords, 'testpass123');
      final json = jsonDecode(utf8.decode(result.data!)) as Map<String, dynamic>;
      expect(json['magic'], 'QRIORA_EXPORT');
      expect(json['version'], 1);
      expect(json['count'], 2);
    });
  });
}
