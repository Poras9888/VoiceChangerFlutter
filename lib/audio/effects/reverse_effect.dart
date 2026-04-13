import 'effect_base.dart';
import 'effect_category.dart';

class ReverseEffect extends GenericVoiceEffect {
  ReverseEffect()
      : super(
          nameValue: 'Reverse',
          emojiValue: '🔁',
          categoryValue: EffectCategory.other,
          reverse: true,
        );
}
