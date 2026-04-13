import 'effect_category.dart';

abstract class VoiceEffect {
  String get name;
  String get emoji;
  EffectCategory get category;
  Future<String> process(String inputPath);
}
