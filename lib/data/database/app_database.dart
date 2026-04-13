import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/effect_presets_table.dart';
import 'tables/recordings_table.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbFile = File(p.join(dir.path, 'voice_changer.sqlite'));
    return NativeDatabase(dbFile);
  });
}

@DriftDatabase(tables: [Recordings, EffectPresets])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  Future<void> ensureReady() async {
    await customStatement(
      'CREATE TABLE IF NOT EXISTS recordings ('
      'id TEXT PRIMARY KEY, '
      'file_name TEXT NOT NULL, '
      'file_path TEXT NOT NULL, '
      'duration INTEGER NOT NULL, '
      'effect_name TEXT NOT NULL, '
      'created_at INTEGER NOT NULL, '
      'is_favorite INTEGER NOT NULL DEFAULT 0'
      ')',
    );

    await customStatement(
      'CREATE TABLE IF NOT EXISTS effect_presets ('
      'id TEXT PRIMARY KEY, '
      'name TEXT NOT NULL, '
      'category TEXT NOT NULL, '
      'pitch_shift REAL NOT NULL, '
      'speed REAL NOT NULL, '
      'reverb REAL NOT NULL, '
      'distortion REAL NOT NULL, '
      'is_unlocked INTEGER NOT NULL DEFAULT 1'
      ')',
    );
  }

  @override
  int get schemaVersion => 1;
}
