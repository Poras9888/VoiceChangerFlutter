import '../app_database.dart';
import '../../models/effect_preset.dart';

class EffectPresetDao {
  EffectPresetDao(this.db);

  final AppDatabase db;

  Future<List<EffectPresetModel>> getAll() async => db.presets;
}
