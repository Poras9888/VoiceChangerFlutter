import 'dart:isolate';

import 'package:flutter_tts/flutter_tts.dart';

class ConvertTextToSpeechUseCase {
  final FlutterTts _tts = FlutterTts();

  Future<void> call({
    required String text,
    required String language,
    required double speed,
    required double pitch,
  }) async {
    final preparedText = await Isolate.run(() => text.trim());
    await _tts.setLanguage(language);
    await _tts.setSpeechRate(speed);
    await _tts.setPitch(pitch);
    await _tts.speak(preparedText);
  }
}
