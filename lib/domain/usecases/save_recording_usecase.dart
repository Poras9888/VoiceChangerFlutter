import '../../data/repositories/recording_repository.dart';
import '../entities/recording_entity.dart';

class SaveRecordingUseCase {
  const SaveRecordingUseCase(this._repository);

  final RecordingRepository _repository;

  Future<void> call(RecordingEntity recording) => _repository.saveRecording(recording);
}
