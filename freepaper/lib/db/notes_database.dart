import 'package:freepaper/model/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database? _database;

  NotesDatabase._init();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDB("favorite.db");
    return _database;
  }

  Future<Database?> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableNotes (
      ${NoteFields.id} $idType,
      ${NoteFields.imgPath} $textType,
      ${NoteFields.time} $textType
    )
    
    ''');
  }

  Future<Note> create(Note note) async {
    final db = await instance.database;

    final id = await db!.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  // A method that retrieves all the dogs from the dogs table.

  Future<bool?> readImage(String img) async {
    final db = await instance.database;

    final maps = await db!.query(tableNotes,
        columns: NoteFields.values,
        where: '${NoteFields.imgPath}=?',
        whereArgs: [img]);

    if (maps.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;
    final orderBy = '${NoteFields.time} DESC';
    final result = await db!.query(tableNotes, orderBy: orderBy);
    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> delete(String imgPath) async {
    final db = await instance.database;

    return await db!.delete(
      tableNotes,
      where: '${NoteFields.imgPath} = ?',
      whereArgs: [imgPath],
    );
  }

  Future close() async {
    final db = await instance.database;
    db!.close();
  }
}
