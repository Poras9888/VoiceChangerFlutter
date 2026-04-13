import '../../core/utils/file_utils.dart';
import '../audio_processor.dart';
import 'effect_category.dart';
import 'voice_effect.dart';

class GenericVoiceEffect extends VoiceEffect {
  GenericVoiceEffect({
    required this.nameValue,
    required this.emojiValue,
    required this.categoryValue,
    this.pitchSemitones = 0,
    this.speed = 1,
    this.reverb = 0,
    this.distortion = 0,
    this.ringHz,
    this.lowPass,
    this.highPass,
    this.reverse = false,
    this.delayMs,
    this.dualRingHz,
  });

  final String nameValue;
  final String emojiValue;
  final EffectCategory categoryValue;
  final double pitchSemitones;
  final double speed;
  final double reverb;
  final double distortion;
  final double? ringHz;
  final double? lowPass;
  final double? highPass;
  final bool reverse;
  final int? delayMs;
  final List<double>? dualRingHz;

  @override
  String get emoji => emojiValue;

  @override
  String get name => nameValue;

  @override
  EffectCategory get category => categoryValue;

  @override
  Future<String> process(String inputPath) async {
    final outPath = await FileUtils.buildOutputPath(
      fileName: '${name.toLowerCase().replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.m4a',
    );
    return AudioProcessor.staticProcess(
      inputPath: inputPath,
      outputPath: outPath,
      pitchSemitones: pitchSemitones,
      speed: speed,
      reverb: reverb,
      distortion: distortion,
      ringModHz: ringHz,
      lowPassHz: lowPass,
      highPassHz: highPass,
      reverse: reverse,
      delayMs: delayMs,
      dualRingHz: dualRingHz,
    );
  }
}
