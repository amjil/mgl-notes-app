import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

const _dbName = "mgl_notes";
final _sqlite3Uri = Uri.parse('/sqlite3.wasm');
final _driftWorkerUri = Uri.parse('/drift_worker.js');

DatabaseConnection connect() {
  return DatabaseConnection.delayed(Future(() async {
    final db = await WasmDatabase.open(
      databaseName: _dbName,
      sqlite3Uri: _sqlite3Uri,
      driftWorkerUri: _driftWorkerUri,
    );
    return db.resolvedExecutor;
  }));
}
