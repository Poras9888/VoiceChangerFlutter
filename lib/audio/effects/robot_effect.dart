import 'effect_base.dart';
import 'effect_category.dart';

class RobotEffect extends GenericVoiceEffect {
  RobotEffect()
      : super(
          nameValue: 'Robot',
          emojiValue: '🤖',
          categoryValue: EffectCategory.other,
          ringHz: 50,
        );
}
