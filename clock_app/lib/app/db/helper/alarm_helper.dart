import 'package:clock_app/app/model/alarm_info.dart';
import 'package:sqflite/sqflite.dart';

final String tableName = "alarm";
final String columnId = "id";
final String columnTitle = "title";
final String columnDateTime = "alarmDateTime";
final String columnPending = "isPending";
final String columnColorIndex = 'gradientColorIndex';

class AlarmHelper {
  static Database? _database;
  static late AlarmHelper _alarmHelper;

  Future<Database?> get database async {
    // ignore: unnecessary_null_comparison
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "alarm.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tableName ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          $columnDateTime text not null,
          $columnPending integer,
          $columnColorIndex integer)
        ''');
      },
    );
    return database;
  }

  void insertAlarm(AlarmInfo alarmInfo) async {
    var db = await this.database;
    var result = db!.insert(tableName, alarmInfo.toMap());
    print(result);
  }

  Future<List<AlarmInfo>> getAlarms() async {
    List<AlarmInfo> _alarms = [];

    var db = await this.database;
    var result = await db!.query(tableName);
    result.forEach((element) {
      var alarmInfo = AlarmInfo.fromMap(element);
      _alarms.add(alarmInfo);
    });

    return _alarms;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db!.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
