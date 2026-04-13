import 'package:equatable/equatable.dart';

class RecordingState extends Equatable {
  const RecordingState({
    this.isRecording = false,
    this.elapsed = Duration.zero,
    this.amplitudes = const [],
    this.path,
  });

  final bool isRecording;
  final Duration elapsed;
  final List<double> amplitudes;
  final String? path;

  @override
  List<Object?> get props => [isRecording, elapsed, amplitudes, path];
}
