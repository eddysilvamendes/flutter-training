// ignore_for_file: prefer_const_declarations

import 'package:flutter_taskapp_with_local_notification/models/task_mode.dart';
import 'package:flutter_taskapp_with_local_notification/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _database;
  static final int _version = 1;
  static final _tableName = "tasks";
  static final _tableUser = "user";
//=======================SAME==============================================
  static Future<void> initDb() async {
    if (_database != null) {
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + "tasks.db";
        _database =
            await openDatabase(_path, version: _version, onCreate: _createDb);
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }
  }

  static void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $_tableName("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "title STRING,note TEXT, date STRING,"
        "startTime STRING, endTime STRING,"
        "remind INTEGER, repeat STRING,"
        "color INTEGER,"
        "isCompleted INTEGER)");

    await db.execute("CREATE TABLE $_tableUser("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "username STRING ,"
        "email STRING , about TEXT )");
  }

  //=======================TASK==============================================

  static Future<int> insert(Task? task) async {
    return await _database?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
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

  //=======================USER==============================================

  static Future<int> inserUser(User? user) async {
    var info = await _database?.insert(_tableUser, user!.toJson()) ?? 1;
    print(info);
    return info;
  }

  static Future<List<Map<String, dynamic>>> readUser() async {
    var infos = await _database!.query(_tableUser);
    //print(infos);
    return infos;
  }

  static deleteUser(User user) async {
    return await _database!
        .delete(_tableUser, where: "id=?", whereArgs: [user.id]);
  }

  static Future<int> updateUser(
    int id,
    String username,
    String email,
    String about,
  ) async {
    return await _database!.rawUpdate(
      'UPDATE $_tableUser SET username = \'$username\', email = \'$email\',about = \'$about\' WHERE id = $id',
    );
  }
}
