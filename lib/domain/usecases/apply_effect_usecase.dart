import '../../audio/audio_processor.dart';
import '../../audio/effects/voice_effect.dart';

class ApplyEffectUseCase {
  const ApplyEffectUseCase(this._processor);

  final AudioProcessor _processor;

  Future<String> call({required String inputPath, required VoiceEffect effect}) {
    return _processor.applyEffect(inputPath, effect);
  }
}
