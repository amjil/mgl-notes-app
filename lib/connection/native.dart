import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getDatabasePath() async {
  final appDocsDir = await getApplicationDocumentsDirectory();
  final appDir = Directory(join(appDocsDir.path, "./"));
  if (!await appDir.exists()) {
    await appDir.create(recursive: true);
  }
  return join(appDir.path, "mgl_notes.db");
}

/// Database connection for Dart VM (iOS, Android, macOS, etc.).
DatabaseConnection connect() {
  return DatabaseConnection.delayed(Future(() async {
    final dbPath = await getDatabasePath();
    print('SQLite database: $dbPath');
    return NativeDatabase.createBackgroundConnection(File(dbPath));
  }));
}
