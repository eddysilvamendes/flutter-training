// ignore_for_file: prefer_const_declarations

import 'package:flutter_taskapp_with_local_notification/models/task_mode.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _database;
  static final int _version = 1;
  static final _tableName = "tasks";

  static Future<void> initDb() async {
    if (_database != null) {
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + "tasks.db";
        _database = await openDatabase(
          _path,
          version: _version,
          onCreate: (db, version) {
            print("Creating new one");
            return db.execute("CREATE TABLE $_tableName("
                "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                "title STRING,note TEXT, date STRING,"
                "startTime STRING, endTime STRING,"
                "remind INTEGER, repeat STRING,"
                "color INTEGER,"
                "isCompleted INTEGER)");
          },
        );
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }
  }

  static Future<int> insert(Task? task) async {
    return await _database?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("query");
    return await _database!.query(_tableName);
  }

  static delete(Task task) async {
    return await _database!
        .delete(_tableName, where: "id=?", whereArgs: [task.id]);
  }

  static update(int id) async {
    return await _database!.rawUpdate("""
    UPDATE tasks
    SET isCompleted = ?
    WHERE id = ?
    """, [1, id]);
  }

  static Future<int> updatesd(
      int id,
      String title,
      String note,
      String date,
      String startTime,
      String endtTime,
      int reminder,
      int color,
      String repeat,
      int isCompeted) async {
    return await _database!.rawUpdate(
      'UPDATE $_tableName SET title = \'$title\', note = \'$note\', isCompleted = \'$isCompeted\',date = \'$date\',startTime = \'$startTime\',endTime = \'$endtTime\',color = \'$color\',remind = \'$reminder\',repeat = \'$repeat\' WHERE id = $id',
    );
  }
}
