import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

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
    return NativeDatabase.createBackgroundConnection(File(dbPath));
  }));
}
