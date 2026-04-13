import 'effect_base.dart';
import 'effect_category.dart';

class GiantEffect extends GenericVoiceEffect {
  GiantEffect()
      : super(
          nameValue: 'Giant',
          emojiValue: '🗽',
          categoryValue: EffectCategory.other,
          pitchSemitones: -12, speed: 0.8,
        );
}
