// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_const, prefer_const_constructors

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_taskapp_with_local_notification/controller/task_controller.dart';
import 'package:flutter_taskapp_with_local_notification/models/task_mode.dart';

import 'package:flutter_taskapp_with_local_notification/screen/profile/add_profile_info.dart';
import 'package:flutter_taskapp_with_local_notification/screen/settings/new_setting.dart';
// ignore: import_of_legacy_library_into_null_safe

import 'package:flutter_taskapp_with_local_notification/screen/task/add_task_screen.dart';
import 'package:flutter_taskapp_with_local_notification/screen/task/edit_task.dart';
import 'package:flutter_taskapp_with_local_notification/utils/theme.dart';
import 'package:flutter_taskapp_with_local_notification/services/nitification_services.dart';
import 'package:flutter_taskapp_with_local_notification/services/theme_service.dart';
import 'package:flutter_taskapp_with_local_notification/utils/data/menu_items.dart';
import 'package:flutter_taskapp_with_local_notification/utils/menu_items.dart';
import 'package:flutter_taskapp_with_local_notification/widgets/button.dart';
import 'package:flutter_taskapp_with_local_notification/widgets/task_tile.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  //final GoogleSignInAccount user;
  const HomeScreen({
    Key? key,
    /*required this.user*/
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var notifyHelper;
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    _taskController.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Column(
        children: [
          _addtaskBar(),
          _addDatePicker(),
          SizedBox(height: 10),
          _showTasks(),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
            title: "Theme Changed",
            body: Get.isDarkMode
                ? "Activated Light Theme"
                : "Activated Dark Theme",
          );
          //notifyHelper.scheduledNotification();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_rounded : Icons.nightlight_round,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        PopupMenuButton<MenuItem>(
          onSelected: (item) => onSelected(context, item),
          icon: Icon(
            Icons.more_vert,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          itemBuilder: (context) => [
            ...MenuItems.items1.map(buildItem).toList(),
            PopupMenuDivider(),
            ...MenuItems.items2.map(buildItem).toList(),
          ],
        ),
      ],
    );
  }

  _addtaskBar() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(
                  DateTime.now(),
                ),
                style: headingStyle,
              ),
              Text(
                "Today",
                style: subHeadingStyle,
              )
            ],
          ),
          MyButton(
              onTap: () async {
                await Get.to(
                  () => AddTaskScreen(),
                );
                _taskController.getTasks();
              },
              label: "+ Add Task"),
        ],
      ),
    );
  }

  _addDatePicker() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: whiteClr,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        onDateChange: (selectedDate) {
          setState(() {
            _selectedDate = selectedDate;
          });
        },
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (_, index) {
            Task task = _taskController.taskList[index];

            if (task.repeat == "Daily" || task.date == task.date) {
              DateTime date = DateFormat.jm().parse(task.startTime.toString());
              var myTime = DateFormat("HH:mm").format(date);
              var myDate = task.date;

              task.isCompleted == 1
                  ? Container()
                  : notifyHelper.scheduledNotification(
                      int.parse(myTime.toString().split(":")[0]),
                      int.parse(myTime.toString().split(":")[1]),
                      int.parse(myDate.toString().split("/")[1]),
                      task);
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomShee(context, task);
                          },
                          child: TaskTile(task),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            if (task.date == DateFormat.yMd().format(_selectedDate)) {
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomShee(context, task);
                          },
                          child: TaskTile(task),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        );
      }),
    );
  }

  _bottomSheetButton(
      {required String label,
      required VoidCallback onTap,
      required Color color,
      bool isClosed = false,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClosed == true
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : color,
          ),
          borderRadius: BorderRadius.circular(10),
          color: isClosed == true ? Colors.transparent : color,
        ),
        child: Center(
          child: Text(
            label,
            style: isClosed
                ? titleStyle
                : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _showBottomShee(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(top: 4),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.40
            : MediaQuery.of(context).size.height * 0.50,
        color: Get.isDarkMode ? darkGreyClr : whiteClr,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
              ),
            ),
            Spacer(),
            task.isCompleted == 1
                ? Container()
                : _bottomSheetButton(
                    label: "Task Completed",
                    onTap: () {
                      _taskController.updateTaskCompleted(task.id!);
                      Get.back();
                      Get.snackbar("Completed", "Your Task has been completed",
                          icon: Icon(Icons.done),
                          snackPosition: SnackPosition.BOTTOM);
                    },
                    color: primaryClr,
                    context: context,
                  ),
            _bottomSheetButton(
              label: "Edit Task",
              onTap: () async {
                Get.back();
                await Get.to(
                  () => EditTaskScreen(
                    task: task,
                  ),
                );
              },
              color: yellowClr,
              context: context,
            ),
            _bottomSheetButton(
              label: "Delete Task",
              onTap: () {
                _taskController.delete(task);

                Get.back();
                Get.snackbar(
                  "Delete",
                  "Your Task has been deleted",
                  icon: Icon(Icons.delete),
                  snackPosition: SnackPosition.BOTTOM,
                  duration: Duration(seconds: 1),
                );
              },
              color: Colors.red[300]!,
              context: context,
            ),
            SizedBox(height: 20),
            _bottomSheetButton(
              label: "Close",
              onTap: () {
                Get.back();
              },
              color: Colors.red[300]!,
              isClosed: true,
              context: context,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem<MenuItem>(
        value: item,
        child: Row(
          children: [
            Icon(
              item.icon,
              size: 20,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
            SizedBox(width: 12),
            Text(item.text),
          ],
        ),
      );

  onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.itemSetting:
        Get.to(() => NewSettingScreen());
        break;
      case MenuItems.itemProfile:
        Get.to(() => AddProfileScreen());
        break;
    }
  }
}
