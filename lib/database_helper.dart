import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int _version = 2;
  static const String _dbName = "Notes.db";
  static Database? _db;

  static Future<Database> get database async {
    return _db ?? await _initialize();
  }

  static Future<Database> _initialize() async {
    final path = join(await getDatabasesPath(), _dbName);
    Database database = await openDatabase(path,
        version: _version, onCreate: createTable, singleInstance: true);
    return database;
  }

  static const notesTable = 'NOTES';
  static Future<void> createTable(Database database, int version) async {
    await database.execute("""
    CREATE TABLE IF NOT EXISTS $notesTable
    (
    "ID" INTEGER NOT NULL,
    "TITLE" TEXT NOT NULL,
    "DESCRIPTION" TEXT NOT NULL,
    "LASTUPDATE" TEXT NOT NULL DEFAULT (DATE('now')),
    "Done" INTEGER NOT NULL DEFAULT 0
    PRIMARY KEY("ID" AUTOINCREMENT)
    );""");
  }

  static Future<int> addNote((String, String) record) async {
    final db = await database;
    return await db.rawInsert('''
  INSERT INTO $notesTable (TITLE,DESCRIPTION,LASTUPDATE) VAlUES (?,?,?)
    ''', [record.$1, record.$2, DateTime.now().toIso8601String()]);
  }

  static Future<List<Map<String, Object?>>> fetchAllNotes() async {
    _db = await database;
    final notes = await _db!.rawQuery('''
    SELECT * FROM $notesTable ORDER BY COALESCE (LASTUPDATE,TITLE)
    ''');
    return notes;
  }

  static Future<int> deleteOneNote(int id) async {
    _db = await database;
    return await _db!.delete(
      notesTable,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<int> deleteAllNotes() async {
    _db = await database;
    return await _db!.delete(notesTable);
  }

  static Future<int> updateNote((int, String, String) record) async {
    _db = await database;
    return await _db!.update(
      notesTable,
      {
        "TITLE": record.$2,
        "DESCRIPTION": record.$3,
        "LASTUPDATE": DateTime.now().toIso8601String()
      },
      where: "id = ?",
      whereArgs: [record.$1],
    );
  }
}
