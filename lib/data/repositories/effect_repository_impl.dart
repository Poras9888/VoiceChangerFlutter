import '../../domain/entities/effect_entity.dart';
import 'effect_repository.dart';

class EffectRepositoryImpl implements EffectRepository {
  final List<EffectEntity> _effects = const [
    EffectEntity(
      id: 'normal',
      name: 'Normal',
      category: 'other',
      pitchShift: 0,
      speed: 1,
      reverb: 0,
      distortion: 0,
    ),
    EffectEntity(
      id: 'robot',
      name: 'Robot',
      category: 'other',
      pitchShift: 0,
      speed: 1,
      reverb: 0,
      distortion: 0.2,
    ),
    EffectEntity(
      id: 'monster',
      name: 'Monster',
      category: 'scary',
      pitchShift: -8,
      speed: 0.9,
      reverb: 0.2,
      distortion: 0.3,
    ),
  ];

  @override
  Future<List<EffectEntity>> getEffects() async => _effects;

  @override
  Future<EffectEntity?> getEffectByName(String name) async {
    try {
      return _effects.firstWhere((e) => e.name.toLowerCase() == name.toLowerCase());
    } catch (_) {
      return null;
    }
  }
}
