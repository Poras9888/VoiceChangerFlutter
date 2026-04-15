import '../app_database.dart';

class EffectPresetDao {
  EffectPresetDao(this.db);

  final AppDatabase db;

  Future<List<Map<String, Object?>>> getAll() async {
    final rows = await db.customSelect('SELECT * FROM effect_presets ORDER BY name ASC').get();
    return rows.map((r) => r.data).toList(growable: false);
  }
}
