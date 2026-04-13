import 'effect_base.dart';
import 'effect_category.dart';

class AlienEffect extends GenericVoiceEffect {
  AlienEffect()
      : super(
          nameValue: 'Alien',
          emojiValue: '👽',
          categoryValue: EffectCategory.other,
          pitchSemitones: 4, reverb: 0.1,
        );
}
