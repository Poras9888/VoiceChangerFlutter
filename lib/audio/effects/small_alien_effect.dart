import 'effect_base.dart';
import 'effect_category.dart';

class SmallAlienEffect extends GenericVoiceEffect {
  SmallAlienEffect()
      : super(
          nameValue: 'Small Alien',
          emojiValue: '🛸',
          categoryValue: EffectCategory.other,
          pitchSemitones: 12,
        );
}
