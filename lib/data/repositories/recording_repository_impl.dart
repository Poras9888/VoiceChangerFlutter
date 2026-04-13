import '../../domain/entities/recording_entity.dart';
import '../database/app_database.dart';
import '../models/recording.dart';
import 'recording_repository.dart';

class RecordingRepositoryImpl implements RecordingRepository {
  RecordingRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<void> deleteAll() async {
    _db.recordings.clear();
  }

  @override
  Future<void> deleteRecording(String id) async {
    _db.recordings.removeWhere((item) => item.id == id);
  }

  @override
  Future<List<RecordingEntity>> getRecordings() async {
    return _db.recordings
        .map(
          (r) => RecordingEntity(
            id: r.id,
            fileName: r.fileName,
            filePath: r.filePath,
            duration: r.duration,
            effectName: r.effectName,
            createdAt: r.createdAt,
            isFavorite: r.isFavorite,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<void> saveRecording(RecordingEntity recording) async {
    _db.recordings.add(
      RecordingModel(
        id: recording.id,
        fileName: recording.fileName,
        filePath: recording.filePath,
        duration: recording.duration,
        effectName: recording.effectName,
        createdAt: recording.createdAt,
        isFavorite: recording.isFavorite,
      ),
    );
  }
}
