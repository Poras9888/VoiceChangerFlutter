import 'effect_base.dart';
import 'effect_category.dart';

class NormalEffect extends GenericVoiceEffect {
  NormalEffect()
      : super(
          nameValue: 'Normal',
          emojiValue: '⭕',
          categoryValue: EffectCategory.other,
          
        );
}
