import 'effect_base.dart';
import 'effect_category.dart';

class DrunkEffect extends GenericVoiceEffect {
  DrunkEffect()
      : super(
          nameValue: 'Drunk',
          emojiValue: '🥴',
          categoryValue: EffectCategory.other,
          pitchSemitones: -2, reverb: 0.2,
        );
}
