// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qriora_database.dart';

// ignore_for_file: type=lint
class $ScanRecordsTable extends ScanRecords
    with TableInfo<$ScanRecordsTable, ScanRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScanRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rawValueMeta = const VerificationMeta(
    'rawValue',
  );
  @override
  late final GeneratedColumn<String> rawValue = GeneratedColumn<String>(
    'raw_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalisedValueMeta = const VerificationMeta(
    'normalisedValue',
  );
  @override
  late final GeneratedColumn<String> normalisedValue = GeneratedColumn<String>(
    'normalised_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentTypeMeta = const VerificationMeta(
    'contentType',
  );
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
    'content_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _barcodeFormatMeta = const VerificationMeta(
    'barcodeFormat',
  );
  @override
  late final GeneratedColumn<String> barcodeFormat = GeneratedColumn<String>(
    'barcode_format',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scannedAtMeta = const VerificationMeta(
    'scannedAt',
  );
  @override
  late final GeneratedColumn<DateTime> scannedAt = GeneratedColumn<DateTime>(
    'scanned_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _analysisJsonMeta = const VerificationMeta(
    'analysisJson',
  );
  @override
  late final GeneratedColumn<String> analysisJson = GeneratedColumn<String>(
    'analysis_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFavouriteMeta = const VerificationMeta(
    'isFavourite',
  );
  @override
  late final GeneratedColumn<bool> isFavourite = GeneratedColumn<bool>(
    'is_favourite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favourite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSensitiveMeta = const VerificationMeta(
    'isSensitive',
  );
  @override
  late final GeneratedColumn<bool> isSensitive = GeneratedColumn<bool>(
    'is_sensitive',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_sensitive" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _analysisVersionMeta = const VerificationMeta(
    'analysisVersion',
  );
  @override
  late final GeneratedColumn<String> analysisVersion = GeneratedColumn<String>(
    'analysis_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    rawValue,
    normalisedValue,
    contentType,
    barcodeFormat,
    source,
    scannedAt,
    analysisJson,
    isFavourite,
    note,
    isSensitive,
    analysisVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scan_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScanRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('raw_value')) {
      context.handle(
        _rawValueMeta,
        rawValue.isAcceptableOrUnknown(data['raw_value']!, _rawValueMeta),
      );
    } else if (isInserting) {
      context.missing(_rawValueMeta);
    }
    if (data.containsKey('normalised_value')) {
      context.handle(
        _normalisedValueMeta,
        normalisedValue.isAcceptableOrUnknown(
          data['normalised_value']!,
          _normalisedValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalisedValueMeta);
    }
    if (data.containsKey('content_type')) {
      context.handle(
        _contentTypeMeta,
        contentType.isAcceptableOrUnknown(
          data['content_type']!,
          _contentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentTypeMeta);
    }
    if (data.containsKey('barcode_format')) {
      context.handle(
        _barcodeFormatMeta,
        barcodeFormat.isAcceptableOrUnknown(
          data['barcode_format']!,
          _barcodeFormatMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_barcodeFormatMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('scanned_at')) {
      context.handle(
        _scannedAtMeta,
        scannedAt.isAcceptableOrUnknown(data['scanned_at']!, _scannedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_scannedAtMeta);
    }
    if (data.containsKey('analysis_json')) {
      context.handle(
        _analysisJsonMeta,
        analysisJson.isAcceptableOrUnknown(
          data['analysis_json']!,
          _analysisJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_analysisJsonMeta);
    }
    if (data.containsKey('is_favourite')) {
      context.handle(
        _isFavouriteMeta,
        isFavourite.isAcceptableOrUnknown(
          data['is_favourite']!,
          _isFavouriteMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('is_sensitive')) {
      context.handle(
        _isSensitiveMeta,
        isSensitive.isAcceptableOrUnknown(
          data['is_sensitive']!,
          _isSensitiveMeta,
        ),
      );
    }
    if (data.containsKey('analysis_version')) {
      context.handle(
        _analysisVersionMeta,
        analysisVersion.isAcceptableOrUnknown(
          data['analysis_version']!,
          _analysisVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_analysisVersionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScanRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScanRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      rawValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_value'],
      )!,
      normalisedValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalised_value'],
      )!,
      contentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_type'],
      )!,
      barcodeFormat: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode_format'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      scannedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scanned_at'],
      )!,
      analysisJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}analysis_json'],
      )!,
      isFavourite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favourite'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      isSensitive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_sensitive'],
      )!,
      analysisVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}analysis_version'],
      )!,
    );
  }

  @override
  $ScanRecordsTable createAlias(String alias) {
    return $ScanRecordsTable(attachedDatabase, alias);
  }
}

class ScanRecord extends DataClass implements Insertable<ScanRecord> {
  final String id;
  final String rawValue;
  final String normalisedValue;
  final String contentType;
  final String barcodeFormat;
  final String source;
  final DateTime scannedAt;
  final String analysisJson;
  final bool isFavourite;
  final String? note;
  final bool isSensitive;
  final String analysisVersion;
  const ScanRecord({
    required this.id,
    required this.rawValue,
    required this.normalisedValue,
    required this.contentType,
    required this.barcodeFormat,
    required this.source,
    required this.scannedAt,
    required this.analysisJson,
    required this.isFavourite,
    this.note,
    required this.isSensitive,
    required this.analysisVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['raw_value'] = Variable<String>(rawValue);
    map['normalised_value'] = Variable<String>(normalisedValue);
    map['content_type'] = Variable<String>(contentType);
    map['barcode_format'] = Variable<String>(barcodeFormat);
    map['source'] = Variable<String>(source);
    map['scanned_at'] = Variable<DateTime>(scannedAt);
    map['analysis_json'] = Variable<String>(analysisJson);
    map['is_favourite'] = Variable<bool>(isFavourite);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_sensitive'] = Variable<bool>(isSensitive);
    map['analysis_version'] = Variable<String>(analysisVersion);
    return map;
  }

  ScanRecordsCompanion toCompanion(bool nullToAbsent) {
    return ScanRecordsCompanion(
      id: Value(id),
      rawValue: Value(rawValue),
      normalisedValue: Value(normalisedValue),
      contentType: Value(contentType),
      barcodeFormat: Value(barcodeFormat),
      source: Value(source),
      scannedAt: Value(scannedAt),
      analysisJson: Value(analysisJson),
      isFavourite: Value(isFavourite),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isSensitive: Value(isSensitive),
      analysisVersion: Value(analysisVersion),
    );
  }

  factory ScanRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScanRecord(
      id: serializer.fromJson<String>(json['id']),
      rawValue: serializer.fromJson<String>(json['rawValue']),
      normalisedValue: serializer.fromJson<String>(json['normalisedValue']),
      contentType: serializer.fromJson<String>(json['contentType']),
      barcodeFormat: serializer.fromJson<String>(json['barcodeFormat']),
      source: serializer.fromJson<String>(json['source']),
      scannedAt: serializer.fromJson<DateTime>(json['scannedAt']),
      analysisJson: serializer.fromJson<String>(json['analysisJson']),
      isFavourite: serializer.fromJson<bool>(json['isFavourite']),
      note: serializer.fromJson<String?>(json['note']),
      isSensitive: serializer.fromJson<bool>(json['isSensitive']),
      analysisVersion: serializer.fromJson<String>(json['analysisVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'rawValue': serializer.toJson<String>(rawValue),
      'normalisedValue': serializer.toJson<String>(normalisedValue),
      'contentType': serializer.toJson<String>(contentType),
      'barcodeFormat': serializer.toJson<String>(barcodeFormat),
      'source': serializer.toJson<String>(source),
      'scannedAt': serializer.toJson<DateTime>(scannedAt),
      'analysisJson': serializer.toJson<String>(analysisJson),
      'isFavourite': serializer.toJson<bool>(isFavourite),
      'note': serializer.toJson<String?>(note),
      'isSensitive': serializer.toJson<bool>(isSensitive),
      'analysisVersion': serializer.toJson<String>(analysisVersion),
    };
  }

  ScanRecord copyWith({
    String? id,
    String? rawValue,
    String? normalisedValue,
    String? contentType,
    String? barcodeFormat,
    String? source,
    DateTime? scannedAt,
    String? analysisJson,
    bool? isFavourite,
    Value<String?> note = const Value.absent(),
    bool? isSensitive,
    String? analysisVersion,
  }) => ScanRecord(
    id: id ?? this.id,
    rawValue: rawValue ?? this.rawValue,
    normalisedValue: normalisedValue ?? this.normalisedValue,
    contentType: contentType ?? this.contentType,
    barcodeFormat: barcodeFormat ?? this.barcodeFormat,
    source: source ?? this.source,
    scannedAt: scannedAt ?? this.scannedAt,
    analysisJson: analysisJson ?? this.analysisJson,
    isFavourite: isFavourite ?? this.isFavourite,
    note: note.present ? note.value : this.note,
    isSensitive: isSensitive ?? this.isSensitive,
    analysisVersion: analysisVersion ?? this.analysisVersion,
  );
  ScanRecord copyWithCompanion(ScanRecordsCompanion data) {
    return ScanRecord(
      id: data.id.present ? data.id.value : this.id,
      rawValue: data.rawValue.present ? data.rawValue.value : this.rawValue,
      normalisedValue: data.normalisedValue.present
          ? data.normalisedValue.value
          : this.normalisedValue,
      contentType: data.contentType.present
          ? data.contentType.value
          : this.contentType,
      barcodeFormat: data.barcodeFormat.present
          ? data.barcodeFormat.value
          : this.barcodeFormat,
      source: data.source.present ? data.source.value : this.source,
      scannedAt: data.scannedAt.present ? data.scannedAt.value : this.scannedAt,
      analysisJson: data.analysisJson.present
          ? data.analysisJson.value
          : this.analysisJson,
      isFavourite: data.isFavourite.present
          ? data.isFavourite.value
          : this.isFavourite,
      note: data.note.present ? data.note.value : this.note,
      isSensitive: data.isSensitive.present
          ? data.isSensitive.value
          : this.isSensitive,
      analysisVersion: data.analysisVersion.present
          ? data.analysisVersion.value
          : this.analysisVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScanRecord(')
          ..write('id: $id, ')
          ..write('rawValue: $rawValue, ')
          ..write('normalisedValue: $normalisedValue, ')
          ..write('contentType: $contentType, ')
          ..write('barcodeFormat: $barcodeFormat, ')
          ..write('source: $source, ')
          ..write('scannedAt: $scannedAt, ')
          ..write('analysisJson: $analysisJson, ')
          ..write('isFavourite: $isFavourite, ')
          ..write('note: $note, ')
          ..write('isSensitive: $isSensitive, ')
          ..write('analysisVersion: $analysisVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    rawValue,
    normalisedValue,
    contentType,
    barcodeFormat,
    source,
    scannedAt,
    analysisJson,
    isFavourite,
    note,
    isSensitive,
    analysisVersion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScanRecord &&
          other.id == this.id &&
          other.rawValue == this.rawValue &&
          other.normalisedValue == this.normalisedValue &&
          other.contentType == this.contentType &&
          other.barcodeFormat == this.barcodeFormat &&
          other.source == this.source &&
          other.scannedAt == this.scannedAt &&
          other.analysisJson == this.analysisJson &&
          other.isFavourite == this.isFavourite &&
          other.note == this.note &&
          other.isSensitive == this.isSensitive &&
          other.analysisVersion == this.analysisVersion);
}

class ScanRecordsCompanion extends UpdateCompanion<ScanRecord> {
  final Value<String> id;
  final Value<String> rawValue;
  final Value<String> normalisedValue;
  final Value<String> contentType;
  final Value<String> barcodeFormat;
  final Value<String> source;
  final Value<DateTime> scannedAt;
  final Value<String> analysisJson;
  final Value<bool> isFavourite;
  final Value<String?> note;
  final Value<bool> isSensitive;
  final Value<String> analysisVersion;
  final Value<int> rowid;
  const ScanRecordsCompanion({
    this.id = const Value.absent(),
    this.rawValue = const Value.absent(),
    this.normalisedValue = const Value.absent(),
    this.contentType = const Value.absent(),
    this.barcodeFormat = const Value.absent(),
    this.source = const Value.absent(),
    this.scannedAt = const Value.absent(),
    this.analysisJson = const Value.absent(),
    this.isFavourite = const Value.absent(),
    this.note = const Value.absent(),
    this.isSensitive = const Value.absent(),
    this.analysisVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScanRecordsCompanion.insert({
    required String id,
    required String rawValue,
    required String normalisedValue,
    required String contentType,
    required String barcodeFormat,
    required String source,
    required DateTime scannedAt,
    required String analysisJson,
    this.isFavourite = const Value.absent(),
    this.note = const Value.absent(),
    this.isSensitive = const Value.absent(),
    required String analysisVersion,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       rawValue = Value(rawValue),
       normalisedValue = Value(normalisedValue),
       contentType = Value(contentType),
       barcodeFormat = Value(barcodeFormat),
       source = Value(source),
       scannedAt = Value(scannedAt),
       analysisJson = Value(analysisJson),
       analysisVersion = Value(analysisVersion);
  static Insertable<ScanRecord> custom({
    Expression<String>? id,
    Expression<String>? rawValue,
    Expression<String>? normalisedValue,
    Expression<String>? contentType,
    Expression<String>? barcodeFormat,
    Expression<String>? source,
    Expression<DateTime>? scannedAt,
    Expression<String>? analysisJson,
    Expression<bool>? isFavourite,
    Expression<String>? note,
    Expression<bool>? isSensitive,
    Expression<String>? analysisVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rawValue != null) 'raw_value': rawValue,
      if (normalisedValue != null) 'normalised_value': normalisedValue,
      if (contentType != null) 'content_type': contentType,
      if (barcodeFormat != null) 'barcode_format': barcodeFormat,
      if (source != null) 'source': source,
      if (scannedAt != null) 'scanned_at': scannedAt,
      if (analysisJson != null) 'analysis_json': analysisJson,
      if (isFavourite != null) 'is_favourite': isFavourite,
      if (note != null) 'note': note,
      if (isSensitive != null) 'is_sensitive': isSensitive,
      if (analysisVersion != null) 'analysis_version': analysisVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScanRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? rawValue,
    Value<String>? normalisedValue,
    Value<String>? contentType,
    Value<String>? barcodeFormat,
    Value<String>? source,
    Value<DateTime>? scannedAt,
    Value<String>? analysisJson,
    Value<bool>? isFavourite,
    Value<String?>? note,
    Value<bool>? isSensitive,
    Value<String>? analysisVersion,
    Value<int>? rowid,
  }) {
    return ScanRecordsCompanion(
      id: id ?? this.id,
      rawValue: rawValue ?? this.rawValue,
      normalisedValue: normalisedValue ?? this.normalisedValue,
      contentType: contentType ?? this.contentType,
      barcodeFormat: barcodeFormat ?? this.barcodeFormat,
      source: source ?? this.source,
      scannedAt: scannedAt ?? this.scannedAt,
      analysisJson: analysisJson ?? this.analysisJson,
      isFavourite: isFavourite ?? this.isFavourite,
      note: note ?? this.note,
      isSensitive: isSensitive ?? this.isSensitive,
      analysisVersion: analysisVersion ?? this.analysisVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (rawValue.present) {
      map['raw_value'] = Variable<String>(rawValue.value);
    }
    if (normalisedValue.present) {
      map['normalised_value'] = Variable<String>(normalisedValue.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (barcodeFormat.present) {
      map['barcode_format'] = Variable<String>(barcodeFormat.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (scannedAt.present) {
      map['scanned_at'] = Variable<DateTime>(scannedAt.value);
    }
    if (analysisJson.present) {
      map['analysis_json'] = Variable<String>(analysisJson.value);
    }
    if (isFavourite.present) {
      map['is_favourite'] = Variable<bool>(isFavourite.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isSensitive.present) {
      map['is_sensitive'] = Variable<bool>(isSensitive.value);
    }
    if (analysisVersion.present) {
      map['analysis_version'] = Variable<String>(analysisVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScanRecordsCompanion(')
          ..write('id: $id, ')
          ..write('rawValue: $rawValue, ')
          ..write('normalisedValue: $normalisedValue, ')
          ..write('contentType: $contentType, ')
          ..write('barcodeFormat: $barcodeFormat, ')
          ..write('source: $source, ')
          ..write('scannedAt: $scannedAt, ')
          ..write('analysisJson: $analysisJson, ')
          ..write('isFavourite: $isFavourite, ')
          ..write('note: $note, ')
          ..write('isSensitive: $isSensitive, ')
          ..write('analysisVersion: $analysisVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$QrioraDatabase extends GeneratedDatabase {
  _$QrioraDatabase(QueryExecutor e) : super(e);
  $QrioraDatabaseManager get managers => $QrioraDatabaseManager(this);
  late final $ScanRecordsTable scanRecords = $ScanRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [scanRecords];
}

typedef $$ScanRecordsTableCreateCompanionBuilder =
    ScanRecordsCompanion Function({
      required String id,
      required String rawValue,
      required String normalisedValue,
      required String contentType,
      required String barcodeFormat,
      required String source,
      required DateTime scannedAt,
      required String analysisJson,
      Value<bool> isFavourite,
      Value<String?> note,
      Value<bool> isSensitive,
      required String analysisVersion,
      Value<int> rowid,
    });
typedef $$ScanRecordsTableUpdateCompanionBuilder =
    ScanRecordsCompanion Function({
      Value<String> id,
      Value<String> rawValue,
      Value<String> normalisedValue,
      Value<String> contentType,
      Value<String> barcodeFormat,
      Value<String> source,
      Value<DateTime> scannedAt,
      Value<String> analysisJson,
      Value<bool> isFavourite,
      Value<String?> note,
      Value<bool> isSensitive,
      Value<String> analysisVersion,
      Value<int> rowid,
    });

class $$ScanRecordsTableFilterComposer
    extends Composer<_$QrioraDatabase, $ScanRecordsTable> {
  $$ScanRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawValue => $composableBuilder(
    column: $table.rawValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalisedValue => $composableBuilder(
    column: $table.normalisedValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcodeFormat => $composableBuilder(
    column: $table.barcodeFormat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scannedAt => $composableBuilder(
    column: $table.scannedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get analysisJson => $composableBuilder(
    column: $table.analysisJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavourite => $composableBuilder(
    column: $table.isFavourite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSensitive => $composableBuilder(
    column: $table.isSensitive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get analysisVersion => $composableBuilder(
    column: $table.analysisVersion,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ScanRecordsTableOrderingComposer
    extends Composer<_$QrioraDatabase, $ScanRecordsTable> {
  $$ScanRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawValue => $composableBuilder(
    column: $table.rawValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalisedValue => $composableBuilder(
    column: $table.normalisedValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcodeFormat => $composableBuilder(
    column: $table.barcodeFormat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scannedAt => $composableBuilder(
    column: $table.scannedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get analysisJson => $composableBuilder(
    column: $table.analysisJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavourite => $composableBuilder(
    column: $table.isFavourite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSensitive => $composableBuilder(
    column: $table.isSensitive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get analysisVersion => $composableBuilder(
    column: $table.analysisVersion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScanRecordsTableAnnotationComposer
    extends Composer<_$QrioraDatabase, $ScanRecordsTable> {
  $$ScanRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get rawValue =>
      $composableBuilder(column: $table.rawValue, builder: (column) => column);

  GeneratedColumn<String> get normalisedValue => $composableBuilder(
    column: $table.normalisedValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get barcodeFormat => $composableBuilder(
    column: $table.barcodeFormat,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get scannedAt =>
      $composableBuilder(column: $table.scannedAt, builder: (column) => column);

  GeneratedColumn<String> get analysisJson => $composableBuilder(
    column: $table.analysisJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavourite => $composableBuilder(
    column: $table.isFavourite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get isSensitive => $composableBuilder(
    column: $table.isSensitive,
    builder: (column) => column,
  );

  GeneratedColumn<String> get analysisVersion => $composableBuilder(
    column: $table.analysisVersion,
    builder: (column) => column,
  );
}

class $$ScanRecordsTableTableManager
    extends
        RootTableManager<
          _$QrioraDatabase,
          $ScanRecordsTable,
          ScanRecord,
          $$ScanRecordsTableFilterComposer,
          $$ScanRecordsTableOrderingComposer,
          $$ScanRecordsTableAnnotationComposer,
          $$ScanRecordsTableCreateCompanionBuilder,
          $$ScanRecordsTableUpdateCompanionBuilder,
          (
            ScanRecord,
            BaseReferences<_$QrioraDatabase, $ScanRecordsTable, ScanRecord>,
          ),
          ScanRecord,
          PrefetchHooks Function()
        > {
  $$ScanRecordsTableTableManager(_$QrioraDatabase db, $ScanRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScanRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScanRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScanRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> rawValue = const Value.absent(),
                Value<String> normalisedValue = const Value.absent(),
                Value<String> contentType = const Value.absent(),
                Value<String> barcodeFormat = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> scannedAt = const Value.absent(),
                Value<String> analysisJson = const Value.absent(),
                Value<bool> isFavourite = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isSensitive = const Value.absent(),
                Value<String> analysisVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScanRecordsCompanion(
                id: id,
                rawValue: rawValue,
                normalisedValue: normalisedValue,
                contentType: contentType,
                barcodeFormat: barcodeFormat,
                source: source,
                scannedAt: scannedAt,
                analysisJson: analysisJson,
                isFavourite: isFavourite,
                note: note,
                isSensitive: isSensitive,
                analysisVersion: analysisVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String rawValue,
                required String normalisedValue,
                required String contentType,
                required String barcodeFormat,
                required String source,
                required DateTime scannedAt,
                required String analysisJson,
                Value<bool> isFavourite = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isSensitive = const Value.absent(),
                required String analysisVersion,
                Value<int> rowid = const Value.absent(),
              }) => ScanRecordsCompanion.insert(
                id: id,
                rawValue: rawValue,
                normalisedValue: normalisedValue,
                contentType: contentType,
                barcodeFormat: barcodeFormat,
                source: source,
                scannedAt: scannedAt,
                analysisJson: analysisJson,
                isFavourite: isFavourite,
                note: note,
                isSensitive: isSensitive,
                analysisVersion: analysisVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ScanRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$QrioraDatabase,
      $ScanRecordsTable,
      ScanRecord,
      $$ScanRecordsTableFilterComposer,
      $$ScanRecordsTableOrderingComposer,
      $$ScanRecordsTableAnnotationComposer,
      $$ScanRecordsTableCreateCompanionBuilder,
      $$ScanRecordsTableUpdateCompanionBuilder,
      (
        ScanRecord,
        BaseReferences<_$QrioraDatabase, $ScanRecordsTable, ScanRecord>,
      ),
      ScanRecord,
      PrefetchHooks Function()
    >;

class $QrioraDatabaseManager {
  final _$QrioraDatabase _db;
  $QrioraDatabaseManager(this._db);
  $$ScanRecordsTableTableManager get scanRecords =>
      $$ScanRecordsTableTableManager(_db, _db.scanRecords);
}
