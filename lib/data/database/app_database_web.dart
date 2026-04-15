class AppDatabase {
  Future<void> ensureReady() async {}

  Future<void> customStatement(String statement, [List<Object?>? args]) async {}

  Future<_QueryResult> customSelect(String statement, [List<Object?>? args]) async {
    return const _QueryResult([]);
  }
}

class _QueryResult {
  const _QueryResult(this.rows);

  final List<_QueryRow> rows;

  Future<List<_QueryRow>> get() async => rows;
}

class _QueryRow {
  const _QueryRow(this.data);

  final Map<String, Object?> data;

  T? read<T>(String key) => data[key] as T?;
}