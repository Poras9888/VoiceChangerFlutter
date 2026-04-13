import 'effect_base.dart';
import 'effect_category.dart';

class MonsterEffect extends GenericVoiceEffect {
  MonsterEffect()
      : super(
          nameValue: 'Monster',
          emojiValue: '👹',
          categoryValue: EffectCategory.scary,
          pitchSemitones: -8, distortion: 0.3,
        );
}
