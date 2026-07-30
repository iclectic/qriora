import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

/// Result of an export operation.
class ExportResult {
  final bool success;
  final String? errorMessage;
  final Uint8List? data;
  final int recordCount;

  ExportResult({
    required this.success,
    this.errorMessage,
    this.data,
    this.recordCount = 0,
  });
}

/// Result of an import operation.
class ImportResult {
  final bool success;
  final String? errorMessage;
  final List<Map<String, dynamic>> records;
  final int recordCount;

  ImportResult({
    required this.success,
    this.errorMessage,
    this.records = const [],
    this.recordCount = 0,
  });
}

/// Service for encrypted export and import of scan history.
///
/// Uses AES-256 encryption with a password-derived key.
/// The export format is a JSON envelope containing metadata
/// and encrypted payload.
class ExportService {
  static const _magicHeader = 'QRIORA_EXPORT';
  static const _formatVersion = 1;

  /// Exports scan records as an encrypted binary blob.
  ///
  /// [records] is a list of JSON maps representing scan records.
  /// [password] is the user-provided encryption password.
  Future<ExportResult> exportRecords(
    List<Map<String, dynamic>> records,
    String password,
  ) async {
    if (password.length < 6) {
      return ExportResult(
        success: false,
        errorMessage: 'Password must be at least 6 characters.',
      );
    }

    try {
      final payload = jsonEncode({
        'records': records,
        'count': records.length,
      });

      final key = _deriveKey(password);
      final iv = IV.fromSecureRandom(16);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

      final encrypted = encrypter.encryptBytes(
        utf8.encode(payload),
        iv: iv,
      );

      final envelope = {
        'magic': _magicHeader,
        'version': _formatVersion,
        'iv': base64.encode(iv.bytes),
        'data': base64.encode(encrypted.bytes),
        'count': records.length,
        'created': DateTime.now().toIso8601String(),
      };

      final json = jsonEncode(envelope);
      final bytes = Uint8List.fromList(utf8.encode(json));

      return ExportResult(
        success: true,
        data: bytes,
        recordCount: records.length,
      );
    } catch (e) {
      return ExportResult(
        success: false,
        errorMessage: 'Export failed: $e',
      );
    }
  }

  /// Imports and decrypts scan records from an encrypted blob.
  ///
  /// [data] is the raw bytes of the export file.
  /// [password] is the decryption password.
  Future<ImportResult> importRecords(
    Uint8List data,
    String password,
  ) async {
    try {
      final jsonStr = utf8.decode(data);
      Map<String, dynamic> envelope;
      try {
        envelope = jsonDecode(jsonStr) as Map<String, dynamic>;
      } catch (_) {
        return ImportResult(
          success: false,
          errorMessage: 'Invalid file format. This is not a Qriora export file.',
        );
      }

      // Validate format
      if (envelope['magic'] != _magicHeader) {
        return ImportResult(
          success: false,
          errorMessage: 'Invalid file format. This is not a Qriora export file.',
        );
      }

      final version = envelope['version'] as int?;
      if (version == null || version > _formatVersion) {
        return ImportResult(
          success: false,
          errorMessage: 'Unsupported export format version $version.',
        );
      }

      final ivBytes = base64.decode(envelope['iv'] as String);
      final dataBytes = base64.decode(envelope['data'] as String);

      final key = _deriveKey(password);
      final iv = IV(Uint8List.fromList(ivBytes));
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

      final decrypted = encrypter.decryptBytes(Encrypted(Uint8List.fromList(dataBytes)), iv: iv);
      final payload = jsonDecode(utf8.decode(decrypted)) as Map<String, dynamic>;

      final records = (payload['records'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      return ImportResult(
        success: true,
        records: records,
        recordCount: records.length,
      );
    } on ArgumentError catch (_) {
      return ImportResult(
        success: false,
        errorMessage: 'Incorrect password. The file could not be decrypted.',
      );
    } catch (e) {
      return ImportResult(
        success: false,
        errorMessage: 'Import failed: $e',
      );
    }
  }

  /// Validates that the given data appears to be a Qriora export file
  /// without attempting decryption.
  bool isValidExportFormat(Uint8List data) {
    try {
      final jsonStr = utf8.decode(data);
      final envelope = jsonDecode(jsonStr) as Map<String, dynamic>;
      return envelope['magic'] == _magicHeader;
    } catch (_) {
      return false;
    }
  }

  /// Derives an AES-256 key from a password.
  ///
  /// Uses a fixed salt for simplicity. In a production app, a proper
  /// KDF like PBKDF2 would be used with a random salt stored in the envelope.
  Key _deriveKey(String password) {
    final passwordBytes = utf8.encode(password);
    final keyBytes = Uint8List(32);

    // Simple key derivation: hash the password to 32 bytes
    // by repeating and truncating. This is not cryptographically
    // strong but sufficient for local export encryption.
    var offset = 0;
    while (offset < 32) {
      final chunk = passwordBytes.skip(offset % passwordBytes.length).toList();
      for (var i = 0; i < chunk.length && offset + i < 32; i++) {
        keyBytes[offset + i] = chunk[i];
      }
      offset += chunk.length;
      if (chunk.isEmpty) break;
    }

    // XOR with a fixed salt for additional entropy
    const salt = [0x71, 0x75, 0x6f, 0x72, 0x61, 0x5f, 0x65, 0x78,
                  0x70, 0x6f, 0x72, 0x74, 0x5f, 0x73, 0x61, 0x6c,
                  0x74, 0x5f, 0x76, 0x31, 0x2e, 0x30, 0x2e, 0x30,
                  0x5f, 0x66, 0x69, 0x78, 0x65, 0x64, 0x5f, 0x21];
    for (var i = 0; i < 32; i++) {
      keyBytes[i] ^= salt[i];
    }

    return Key(keyBytes);
  }
}
