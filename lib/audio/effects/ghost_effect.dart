import 'effect_base.dart';
import 'effect_category.dart';

class GhostEffect extends GenericVoiceEffect {
  GhostEffect()
      : super(
          nameValue: 'Ghost',
          emojiValue: '👻',
          categoryValue: EffectCategory.scary,
          reverb: 0.9, highPass: 2000,
        );
}
