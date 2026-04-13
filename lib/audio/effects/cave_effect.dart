import 'effect_base.dart';
import 'effect_category.dart';

class CaveEffect extends GenericVoiceEffect {
  CaveEffect()
      : super(
          nameValue: 'Cave',
          emojiValue: '🗿',
          categoryValue: EffectCategory.other,
          reverb: 0.8,
        );
}
