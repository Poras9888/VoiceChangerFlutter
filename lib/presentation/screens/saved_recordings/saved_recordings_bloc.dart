import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../domain/entities/recording_entity.dart';
import 'saved_recordings_event.dart';
import 'saved_recordings_state.dart';

class SavedRecordingsBloc extends Bloc<SavedRecordingsEvent, SavedRecordingsState> {
  SavedRecordingsBloc() : super(const SavedRecordingsState()) {
    on<LoadRecordings>((event, emit) {
      emit(
        SavedRecordingsState(
          items: [
            RecordingEntity(
              id: const Uuid().v4(),
              fileName: 'My Voice 1',
              filePath: '/mock/path.m4a',
              duration: 3400,
              effectName: 'Robot',
              createdAt: DateTime.now().millisecondsSinceEpoch,
            ),
          ],
        ),
      );
    });

    on<SortRecordings>((event, emit) {
      final list = [...state.items];
      if (event.sortType == 'name') {
        list.sort((a, b) => a.fileName.compareTo(b.fileName));
      } else if (event.sortType == 'duration') {
        list.sort((a, b) => a.duration.compareTo(b.duration));
      } else {
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }
      emit(SavedRecordingsState(items: list));
    });
  }
}
