import 'effect_base.dart';
import 'effect_category.dart';

class HexafluorideEffect extends GenericVoiceEffect {
  HexafluorideEffect()
      : super(
          nameValue: 'Hexafluoride',
          emojiValue: '🎈',
          categoryValue: EffectCategory.other,
          pitchSemitones: 8, speed: 1.3,
        );
}
