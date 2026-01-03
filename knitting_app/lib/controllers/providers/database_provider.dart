import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';

class DatabaseProvider extends ChangeNotifier {
  Database? _notepadDatabase;
  bool _isLoading = false;
  bool _isInitialized = false;

  Database get notepadDatabase => _notepadDatabase!; // burada ? ve ! çalış
  bool get isLoading => _isLoading;
  bool get isInitialized => _isInitialized;

  Future<void> initDatabase() async {
    if (_isInitialized) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    _notepadDatabase = await openDatabase(
      join(await getDatabasesPath(), 'notepad_database.db'),

      version: 1,

      onCreate: (db, version) {
        return db.execute('CREATE TABLE notes(id INTEGER PRIMARY KEY)');
      },
    );

    _isLoading = false;
    _isInitialized = true;
    notifyListeners();
  }
}

// Bu dosya db'yi başlatır, katmanı tutar ve UI durumlarını yönetir (loading, initialized)
