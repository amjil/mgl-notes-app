import 'dart:ffi';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// `sqlite3` 3.x with `hooks.user_defines.sqlite3.source: process` looks up
/// symbols in already-loaded modules. `sqlite3_flutter_libs` ships
/// `sqlite3.dll` next to the Windows exe, but does not LoadLibrary it — unlike
/// macOS/iOS/Linux, where SQLite is linked into the plugin. Load it here, in
/// the Drift isolate, before native-asset process lookup runs.
void _preloadSqlite3() {
  if (Platform.isWindows) {
    DynamicLibrary.open('sqlite3.dll');
  }
}

Future<String> getDatabasePath() async {
  final appDocsDir = await getApplicationDocumentsDirectory();
  final appDir = Directory(p.join(appDocsDir.path, 'mgl_notes_data'));
  if (!await appDir.exists()) {
    await appDir.create(recursive: true);
  }
  return p.join(appDir.path, 'mgl_notes.db');
}

DatabaseConnection connect() {
  return DatabaseConnection.delayed(Future(() async {
    final dbPath = await getDatabasePath();
    print('SQLite database: $dbPath');
    return NativeDatabase.createBackgroundConnection(
      File(dbPath),
      isolateSetup: _preloadSqlite3,
    );
  }));
}
