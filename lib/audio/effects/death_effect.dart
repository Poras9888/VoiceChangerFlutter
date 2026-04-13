import 'effect_base.dart';
import 'effect_category.dart';

class DeathEffect extends GenericVoiceEffect {
  DeathEffect()
      : super(
          nameValue: 'Death',
          emojiValue: '💀',
          categoryValue: EffectCategory.scary,
          delayMs: 300, lowPass: 1200,
        );
}
