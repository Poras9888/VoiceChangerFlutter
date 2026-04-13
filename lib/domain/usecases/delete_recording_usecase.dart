import '../../data/repositories/recording_repository.dart';

class DeleteRecordingUseCase {
  const DeleteRecordingUseCase(this._repository);

  final RecordingRepository _repository;

  Future<void> call(String id) => _repository.deleteRecording(id);
}
