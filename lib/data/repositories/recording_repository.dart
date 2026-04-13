import '../../domain/entities/recording_entity.dart';

abstract class RecordingRepository {
  Future<void> saveRecording(RecordingEntity recording);
  Future<List<RecordingEntity>> getRecordings();
  Future<void> deleteRecording(String id);
  Future<void> deleteAll();
}
