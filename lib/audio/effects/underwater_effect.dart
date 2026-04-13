import 'effect_base.dart';
import 'effect_category.dart';

class UnderwaterEffect extends GenericVoiceEffect {
  UnderwaterEffect()
      : super(
          nameValue: 'Underwater',
          emojiValue: '🌊',
          categoryValue: EffectCategory.other,
          lowPass: 800,
        );
}
