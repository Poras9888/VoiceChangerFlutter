import 'package:drift/drift.dart';

import '../app_database.dart';
 
class RecordingDao {
  RecordingDao(this.db);

  final AppDatabase db;

  Future<List<Recording>> getAll() => db.select(db.recordings).get();

  Future<void> insertRecording(RecordingsCompanion entry) => db.into(db.recordings).insert(entry);

  Future<void> deleteById(String id) => (db.delete(db.recordings)..where((tbl) => tbl.id.equals(id))).go();
}
