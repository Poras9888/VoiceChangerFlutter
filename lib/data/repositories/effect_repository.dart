import '../../domain/entities/effect_entity.dart';

abstract class EffectRepository {
  Future<List<EffectEntity>> getEffects();
  Future<EffectEntity?> getEffectByName(String name);
}
