import 'package:flutter/foundation.dart';
import '../database/database.dart';
import '../services/database_service.dart';

/// Simplified database provider
/// Reduces complexity, directly provides simplified database service
class DatabaseProvider extends ChangeNotifier {
  AppDatabase? _database;
  DatabaseService? _databaseService;

  AppDatabase get database {
    if (_database == null) {
      throw Exception('Database not initialized');
    }
    return _database!;
  }

  DatabaseService get databaseService {
    if (_databaseService == null) {
      throw Exception('Database service not initialized');
    }
    return _databaseService!;
  }

  /// Initialize database
  Future<void> initialize() async {
    try {
      _database = AppDatabase();
      _databaseService = DatabaseService(_database!);
      notifyListeners();
    } catch (e) {
      debugPrint('Database initialization failed: $e');
      rethrow;
    }
  }

  /// Close database connection
  Future<void> close() async {
    await _databaseService?.close();
    await _database?.close();
    _database = null;
    _databaseService = null;
    notifyListeners();
  }

  /// Check if initialized
  bool get isInitialized => _database != null && _databaseService != null;
} 