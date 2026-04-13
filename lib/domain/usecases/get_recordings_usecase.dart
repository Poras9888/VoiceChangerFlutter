import '../../data/repositories/recording_repository.dart';
import '../entities/recording_entity.dart';

class GetRecordingsUseCase {
  const GetRecordingsUseCase(this._repository);

  final RecordingRepository _repository;

  Future<List<RecordingEntity>> call() => _repository.getRecordings();
}
