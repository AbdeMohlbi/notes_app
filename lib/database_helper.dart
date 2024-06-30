import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Notes.db";
  Database? _database;

  Future<Database> get database async {
    return _database ?? await _initialize();
  }

  Future<String> get fullPath async {
    final path = await getDatabasesPath();
    return join(path, _dbName);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    Database database = await openDatabase(path,
        version: _version, onCreate: create, singleInstance: true);
    return database;
  }

  Future<void> create(Database database, int version) async {
    await Ccc().createTable(database);
  }
}

class Ccc {
  final tableName = 'NOTES';
  Future<void> createTable(Database database) async {
    await database.execute("""
    CREATE TABLE IF NOT EXISTS $tableName
    (
    "ID" INTEGER NOT NULL,
    "TITLE" TEXT NOT NULL,
    "DESCRIPTION" TEXT NOT NULL,
    "LASTUPDATE" INTEGER NOT NULL DEFAULT (cast(str('%s','now') as int)),
    PRIMARY KEY("ID" AUTOINCREMENT)
    );""");
  }

  Future<int> addNote((String, String) record) async {
    final database = await DatabaseHelper().database;
    return await database.rawInsert('''
  INSERT INTO $tableName (TITLE,DESCRIPTION,LASTUPDATE) VAlUES (?,?,?)
    ''', [record.$1, record.$2, DateTime.now().millisecondsSinceEpoch]);
  }

  Future<void> fetchAll() async {
    final database = await DatabaseHelper().database;
    final notes = await database.rawQuery('''
    SELECT * FROM $tableName ORDER BY COALESCE (LASTUPDATE,TITLE)
    ''');
    print(notes);
  }
}
