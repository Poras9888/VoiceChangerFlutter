import 'package:drift/drift.dart';

class EffectPresets extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  RealColumn get pitchShift => real()();
  RealColumn get speed => real()();
  RealColumn get reverb => real()();
  RealColumn get distortion => real()();
  BoolColumn get isUnlocked => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
