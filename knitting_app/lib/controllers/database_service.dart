import 'package:knitting_app/controllers/providers/database_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await openDatabase(
      join(await getDatabasesPath(), 'app.db'),
      version: 1,
      onCreate: (db, _) async {
        await db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY, text TEXT)',
        );
      },
    );
    return _db!;
  }

  Future<void> insertNote(String text) async {
    final db = await database;
    await db.insert('notes', {'text': text});
  }

  Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await database;
    return db.query('notes');
  }
}
