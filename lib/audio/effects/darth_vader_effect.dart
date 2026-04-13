import 'effect_base.dart';
import 'effect_category.dart';

class DarthVaderEffect extends GenericVoiceEffect {
  DarthVaderEffect()
      : super(
          nameValue: 'Darth Vader',
          emojiValue: '🪖',
          categoryValue: EffectCategory.scary,
          pitchSemitones: -10,
        );
}
