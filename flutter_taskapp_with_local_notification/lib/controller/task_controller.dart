import 'package:flutter_taskapp_with_local_notification/db/db_helper.dart';
import 'package:flutter_taskapp_with_local_notification/models/task_mode.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    DBHelper.delete(task);
    getTasks();
  }

  void updateTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }

  void updatetasks(
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
    await DBHelper.updatesd(id, title, note, date, startTime, endtTime,
        reminder, color, repeat, isCompeted);
  }
}
