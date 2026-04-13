import 'effect_base.dart';
import 'effect_category.dart';

class HeliumEffect extends GenericVoiceEffect {
  HeliumEffect()
      : super(
          nameValue: 'Helium',
          emojiValue: '🎀',
          categoryValue: EffectCategory.other,
          pitchSemitones: 10,
        );
}
