import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbFile = File(p.join(dir.path, 'voice_changer.sqlite'));
    return NativeDatabase(dbFile);
  });
}

class AppDatabase extends GeneratedDatabase {
  AppDatabase() : super(_openConnection());

  Future<void> ensureReady() async {}

  Future<void> customStatement(String statement, [List<Object?>? args]) async {}

  Future<_QueryResult> customSelect(String statement, [List<Object?>? args]) async {
    return _QueryResult(const []);
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async => ensureReady(),
        onUpgrade: (m, from, to) async => ensureReady(),
      );

  @override
  Iterable<TableInfo<Table, Object?>> get allTables => const <TableInfo<Table, Object?>>[];

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => const <DatabaseSchemaEntity>[];
}

class _QueryResult {
  const _QueryResult(this.rows);

  final List<_QueryRow> rows;

  Future<List<_QueryRow>> get() async => rows;
}

class _QueryRow {
  const _QueryRow(this.data);

  final Map<String, Object?> data;

  T? read<T>(String key) => data[key] as T?;
}