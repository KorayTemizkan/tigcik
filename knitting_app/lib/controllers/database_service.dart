import 'package:knitting_app/controllers/providers/database_provider.dart';
import 'package:knitting_app/models/note_model.dart';
import 'package:path/path.dart'; // Veritabanının nereye kaydedileceğini Linux ve Windows platformlarında sorun çıkarmaması için kullanıyoruz
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  final Database db;
  DatabaseService(this.db); //? neden böyle yaptık tam anlamadım

  Future<void> getNotes() async {
    db.query('notes');
  }

  Future<void> addNote(Note note) async {
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateNote(Note note) async {
    await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future deleteNote(int id) async {
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
