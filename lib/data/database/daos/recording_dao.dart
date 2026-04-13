import '../app_database.dart';
import '../../models/recording.dart';

class RecordingDao {
  RecordingDao(this.db);

  final AppDatabase db;

  Future<List<RecordingModel>> getAll() async => db.recordings;

  Future<void> insertRecording(RecordingModel entry) async {
    db.recordings.add(entry);
  }

  Future<void> deleteById(String id) async {
    db.recordings.removeWhere((item) => item.id == id);
  }
}
