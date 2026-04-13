import 'effect_base.dart';
import 'effect_category.dart';

class ZombieEffect extends GenericVoiceEffect {
  ZombieEffect()
      : super(
          nameValue: 'Zombie',
          emojiValue: '🧟',
          categoryValue: EffectCategory.scary,
          pitchSemitones: -5, distortion: 0.4, delayMs: 200,
        );
}
