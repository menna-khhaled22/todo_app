import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'notes.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id TEXT PRIMARY KEY, title TEXT, content TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertNote(String id, String title, String content) async {
    final db = await DBHelper.database();
    await db.insert(
      'notes',
      {'id': id, 'title': title, 'content': content},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> fetchNotes() async {
    final db = await DBHelper.database();
    return db.query('notes');
  }

  static Future<void> deleteNote(String id) async {
    final db = await DBHelper.database();
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
