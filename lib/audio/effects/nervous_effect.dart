import 'effect_base.dart';
import 'effect_category.dart';

class NervousEffect extends GenericVoiceEffect {
  NervousEffect()
      : super(
          nameValue: 'Nervous',
          emojiValue: '😰',
          categoryValue: EffectCategory.other,
          pitchSemitones: 1,
        );
}
