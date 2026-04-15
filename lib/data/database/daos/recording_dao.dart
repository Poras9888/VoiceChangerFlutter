import '../app_database.dart';

class RecordingDao {
  RecordingDao(this.db);

  final AppDatabase db;

  Future<List<Map<String, Object?>>> getAll() async {
    final rows = await db.customSelect('SELECT * FROM recordings ORDER BY created_at DESC').get();
    return rows.map((r) => r.data).toList(growable: false);
  }

  Future<void> insertRecording({
    required String id,
    required String fileName,
    required String filePath,
    required int duration,
    required String effectName,
    required int createdAt,
    required bool isFavorite,
  }) {
    return db.customStatement(
      'INSERT INTO recordings (id, file_name, file_path, duration, effect_name, created_at, is_favorite) '
      'VALUES (?, ?, ?, ?, ?, ?, ?)',
      [id, fileName, filePath, duration, effectName, createdAt, isFavorite ? 1 : 0],
    );
  }

  Future<void> deleteById(String id) => db.customStatement('DELETE FROM recordings WHERE id = ?', [id]);
}
