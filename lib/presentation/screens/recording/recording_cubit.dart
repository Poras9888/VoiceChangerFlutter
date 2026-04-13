import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../audio/audio_recorder.dart';
import '../../../audio/waveform_visualizer.dart';
import '../../../core/utils/file_utils.dart';
import 'recording_state.dart';

class RecordingCubit extends Cubit<RecordingState> {
  RecordingCubit(this._recorder, this._visualizer) : super(const RecordingState());

  final AudioRecorderService _recorder;
  final WaveformVisualizer _visualizer;

  Timer? _timer;
  Duration _elapsed = Duration.zero;
  StreamSubscription<double>? _ampSub;

  Future<void> startRecording() async {
    final path = await FileUtils.buildOutputPath(fileName: 'recording_${DateTime.now().millisecondsSinceEpoch}.pcm');
    await _recorder.start(path);
    _visualizer.start();

    _timer?.cancel();
    _elapsed = Duration.zero;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      _elapsed += const Duration(milliseconds: 10);
      emit(RecordingState(
        isRecording: true,
        elapsed: _elapsed,
        amplitudes: state.amplitudes,
        path: state.path,
      ));
    });

    _ampSub?.cancel();
    final amps = <double>[];
    _ampSub = _visualizer.amplitudeStream.listen((value) {
      amps.add(value);
      if (amps.length > 40) {
        amps.removeAt(0);
      }
      emit(RecordingState(
        isRecording: true,
        elapsed: _elapsed,
        amplitudes: List<double>.from(amps),
        path: state.path,
      ));
    });
  }

  Future<void> stopRecording() async {
    _timer?.cancel();
    _visualizer.stop();
    final path = await _recorder.stop();
    emit(RecordingState(
      isRecording: false,
      elapsed: _elapsed,
      amplitudes: state.amplitudes,
      path: path,
    ));
  }

  Future<void> saveAndApplyEffect() async {}

  @override
  Future<void> close() async {
    _timer?.cancel();
    await _ampSub?.cancel();
    await _visualizer.dispose();
    await _recorder.dispose();
    return super.close();
  }
}
