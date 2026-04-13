import 'package:equatable/equatable.dart';

abstract class SavedRecordingsEvent extends Equatable {
  const SavedRecordingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadRecordings extends SavedRecordingsEvent {
  const LoadRecordings();
}

class SortRecordings extends SavedRecordingsEvent {
  const SortRecordings(this.sortType);
  final String sortType;

  @override
  List<Object?> get props => [sortType];
}
