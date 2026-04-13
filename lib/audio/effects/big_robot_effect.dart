import 'effect_base.dart';
import 'effect_category.dart';

class BigRobotEffect extends GenericVoiceEffect {
  BigRobotEffect()
      : super(
          nameValue: 'Big Robot',
          emojiValue: '🦾',
          categoryValue: EffectCategory.other,
          dualRingHz: const [50, 120],
        );
}
