import 'dart:ffi';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

/// Ensure the sqlite3 from `sqlite3_flutter_libs` is loadable before Drift
/// opens the DB (esp. Android 6 `dlopen` quirks, and Windows where the DLL
/// sits next to the exe but is not linked into the process).
Future<void> _ensureSqlite3Loaded() async {
  if (Platform.isAndroid) {
    await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
  }
}

void _preloadSqlite3InIsolate() {
  if (Platform.isWindows) {
    DynamicLibrary.open('sqlite3.dll');
  } else if (Platform.isAndroid) {
    DynamicLibrary.open('libsqlite3.so');
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
    await _ensureSqlite3Loaded();
    final dbPath = await getDatabasePath();
    print('SQLite database: $dbPath');
    return NativeDatabase.createBackgroundConnection(
      File(dbPath),
      isolateSetup: _preloadSqlite3InIsolate,
    );
  }));
}
