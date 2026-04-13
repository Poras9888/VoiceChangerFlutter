import 'effect_base.dart';
import 'effect_category.dart';

class ChipmunkEffect extends GenericVoiceEffect {
  ChipmunkEffect()
      : super(
          nameValue: 'Chipmunk',
          emojiValue: '🐿️',
          categoryValue: EffectCategory.other,
          speed: 2.0, pitchSemitones: 8,
        );
}
