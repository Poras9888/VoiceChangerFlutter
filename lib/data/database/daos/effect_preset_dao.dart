import 'package:drift/drift.dart';

import '../app_database.dart';
 
class EffectPresetDao {
  EffectPresetDao(this.db);

  final AppDatabase db;

  Future<List<EffectPreset>> getAll() => db.select(db.effectPresets).get();
}
