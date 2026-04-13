import 'effect_base.dart';
import 'effect_category.dart';

class TelephoneEffect extends GenericVoiceEffect {
  TelephoneEffect()
      : super(
          nameValue: 'Telephone',
          emojiValue: '📞',
          categoryValue: EffectCategory.other,
          lowPass: 3400, highPass: 300,
        );
}
