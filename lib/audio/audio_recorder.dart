import 'dart:async';
import 'dart:typed_data';

import 'package:record/record.dart';

import '../core/constants/app_constants.dart';

class AudioRecorderService {
  final AudioRecorder _recorder = AudioRecorder();
  final StreamController<Uint8List> _pcmController = StreamController.broadcast();

  Stream<Uint8List> get pcmStream => _pcmController.stream;

  Future<void> start(String path) async {
    await _recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        sampleRate: AppConstants.sampleRate,
        numChannels: 1,
      ),
      path: path,
    );
  }

  Future<String?> stop() => _recorder.stop();

  Future<void> dispose() async {
    await _recorder.dispose();
    await _pcmController.close();
  }
}
