import '../../domain/entities/recording_entity.dart';
import '../database/app_database.dart';
import 'recording_repository.dart';

class RecordingRepositoryImpl implements RecordingRepository {
  RecordingRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<void> deleteAll() async {
    await _db.customStatement('DELETE FROM recordings');
  }

  @override
  Future<void> deleteRecording(String id) async {
    await _db.customStatement('DELETE FROM recordings WHERE id = ?', [id]);
  }

  @override
  Future<List<RecordingEntity>> getRecordings() async {
    final rows = await _db.customSelect('SELECT * FROM recordings ORDER BY created_at DESC').get();
    return rows
        .map(
          (r) => RecordingEntity(
            id: r.read<String>('id'),
            fileName: r.read<String>('file_name'),
            filePath: r.read<String>('file_path'),
            duration: r.read<int>('duration'),
            effectName: r.read<String>('effect_name'),
            createdAt: r.read<int>('created_at'),
            isFavorite: (r.read<int>('is_favorite') ?? 0) == 1,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<void> saveRecording(RecordingEntity recording) async {
    await _db.customStatement(
      'INSERT INTO recordings (id, file_name, file_path, duration, effect_name, created_at, is_favorite) '
      'VALUES (?, ?, ?, ?, ?, ?, ?)',
      [
        recording.id,
        recording.fileName,
        recording.filePath,
        recording.duration,
        recording.effectName,
        recording.createdAt,
        recording.isFavorite ? 1 : 0,
      ],
    );
  }
}
