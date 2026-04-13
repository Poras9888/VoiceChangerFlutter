import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class Recordings extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get fileName => text()();
  TextColumn get filePath => text()();
  IntColumn get duration => integer()();
  TextColumn get effectName => text()();
  IntColumn get createdAt =>
      integer().clientDefault(() => DateTime.now().millisecondsSinceEpoch)();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
