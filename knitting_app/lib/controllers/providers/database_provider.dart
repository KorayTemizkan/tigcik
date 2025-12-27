import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';

class DatabaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool isInitialized = false;
  Database? notepadDatabase;

  Future<void> initDatabase() async {
    final notepadDatabase = openDatabase(
      join(await getDatabasesPath(), 'notepad_database.db'),

      onCreate: (db, version) {
        return db.execute('CREATE TABLE notes(id INTEGER PRIMARY KEY)');
      },
    );
  }
}
