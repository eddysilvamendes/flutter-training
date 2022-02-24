// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_taskapp_with_local_notification/controller/task_controller.dart';
import 'package:flutter_taskapp_with_local_notification/models/task_mode.dart';
import 'package:flutter_taskapp_with_local_notification/utils/theme.dart';
import 'package:flutter_taskapp_with_local_notification/widgets/button.dart';
import 'package:flutter_taskapp_with_local_notification/widgets/input_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;
  const EditTaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  late DateTime _selectedDate;
  late String _endTime;
  late String _startTime;
  late int _selectedRemind;
  List<int> remindList = [5, 10, 15, 20];
  late String _selectedRepeat;
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];
  late int _selectedColor;
  List<bool> isSelected = [true, false];
  late int isCompleted;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task.title!;
    _noteController.text = widget.task.note!;
    _startTime = widget.task.startTime!;
    _endTime = widget.task.endTime!;
    _selectedColor = widget.task.color!;
    _selectedDate = DateFormat.yMd().parse(widget.task.date!);
    _selectedRemind = widget.task.remind!;
    _selectedRepeat = widget.task.repeat!;
    isCompleted = widget.task.isCompleted!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit Task",
                style: subHeadingStyle,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  isCompleted == 1
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              isCompleted = 0;
                            });
                            Get.snackbar("Change", "Task Status Changed",
                                icon: Icon(Icons.change_circle),
                                snackPosition: SnackPosition.BOTTOM,
                                duration: Duration(seconds: 1));
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _getBGClr(_selectedColor),
                            ),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: "Completed!",
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
              MyInputField(
                title: "Title",
                hint: widget.task.title!.toString(),
                controller: _titleController,
              ),
              MyInputField(
                title: "Note",
                hint: widget.task.note!.toString(),
                controller: _noteController,
              ),
              MyInputField(
                title: "Date",
                hint: widget.task.date!,
                widget: IconButton(
                  onPressed: () {
                    _getShowCallender();
                  },
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: "Start Time",
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () {
                          //_getShowTime(isStartTime: true);
                          _showsTime(context, isStartTime: true);
                        },
                        icon: Icon(
                          Icons.access_time_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: MyInputField(
                      title: "End Time",
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () {
                          //_getShowTime(isStartTime: false);
                          _showsTime(context, isStartTime: false);
                        },
                        icon: Icon(
                          Icons.access_time_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MyInputField(
                title: "Remind",
                hint: " $_selectedRemind minutes early",
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: hintStyle,
                  underline: Container(height: 0),
                  items: remindList.map<DropdownMenuItem<String>>(
                    (int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    },
                  ).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                  },
                ),
              ),
              MyInputField(
                title: "Repeat",
                hint: _selectedRepeat,
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: hintStyle,
                  underline: Container(height: 0),
                  items: repeatList.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _getColor(),
                  MyButton(
                      onTap: () {
                        _validateData();
                      },
                      label: "Edit Task")
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_rounded,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage(
            "images/freeman.png",
          ),
        ),
        SizedBox(width: 15)
      ],
    );
  }

  _getShowCallender() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2122),
    );

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("Something is wrong");
    }
  }

  Future<void> _showsTime(BuildContext context,
      {required bool isStartTime}) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );
    if (timeOfDay == null) {
    } else if (isStartTime == true) {
      setState(() {
        _startTime = timeOfDay.format(context);
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = timeOfDay.format(context);
      });
    }
  }

  _getColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        SizedBox(height: 8.0),
        Wrap(
          children: List<Widget>.generate(
            3,
            (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? primaryClr
                        : index == 1
                            ? pinkClr
                            : yellowClr,
                    child: _selectedColor == index
                        ? Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 16,
                          )
                        : Container(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return yellowClr;
      default:
        return bluishClr;
    }
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      print(_titleController.text);
      print(isCompleted);
      _taskController.updatetasks(
          widget.task.id!,
          _titleController.text,
          _noteController.text,
          DateFormat.yMd().format(_selectedDate),
          _startTime,
          _endTime,
          _selectedRemind,
          _selectedColor,
          _selectedRepeat,
          isCompleted);

      Get.back();
      _taskController.getTasks();
      Get.snackbar("Edited", "Task edited",
          icon: Icon(Icons.add),
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 1));
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "All field are required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: pinkClr,
        icon: Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
      );
    }
  }
}
