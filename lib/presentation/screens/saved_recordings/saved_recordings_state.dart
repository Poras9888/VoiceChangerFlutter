import 'package:equatable/equatable.dart';

import '../../../../domain/entities/recording_entity.dart';

class SavedRecordingsState extends Equatable {
  const SavedRecordingsState({this.items = const []});

  final List<RecordingEntity> items;

  @override
  List<Object?> get props => [items];
}
