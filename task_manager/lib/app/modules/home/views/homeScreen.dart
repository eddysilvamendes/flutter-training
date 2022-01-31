import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hive/hive.dart';
import 'package:task_manager/app/modules/home/widgets/task_widgets.dart';
import 'package:task_manager/app/shared/model/task.dart';
import 'package:task_manager/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);

    return ValueListenableBuilder(
      valueListenable: base.dataStore.listemToTask(),
      builder: (context, Box<Task> box, Widget? child) {
        var tasks = box.values.toList();
        tasks.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: false,
            title: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                margin: EdgeInsets.only(left: 6),
                child: Text(
                  'Tarefas Diarias',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: ListTile(
                          title: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Nome da Tarefa'),
                            onSubmitted: (value) {
                              Navigator.pop(context);
                              DatePicker.showTimePicker(
                                context,
                                showTitleActions: true,
                                showSecondsColumn: false,
                                onConfirm: (date) {
                                  if (value.isNotEmpty) {
                                    var task = Task.create(
                                        name: value, createdAt: date);
                                    base.dataStore.addTask(task: task);
                                  }
                                },
                                currentTime: DateTime.now(),
                              );
                            },
                            autofocus: true,
                          ),
                          // trailing: IconButton(
                          //   onPressed: () {
                          //     print('click click');
                          //     Navigator.pop(context);
                          //     DatePicker.showDateTimePicker(
                          //       context,
                          //       showTitleActions: true,
                          //       minTime: DateTime.now(),
                          //       maxTime: DateTime(2019, 6, 7),
                          //       onChanged: (date) {
                          //         print('change $date');
                          //       },
                          //       onConfirm: (date) {
                          //         print('confirm $date');
                          //       },
                          //       currentTime: DateTime.now(),
                          //     );
                          //   },
                          //   icon: Icon(Icons.alarm),
                          // ),
                        ),
                      );
                    },
                  );
                },
                icon: Icon(Icons.add),
              )
            ],
          ),
          body: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              var task = tasks[index];
              return Dismissible(
                background: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete_outline,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Tarefa Eliminada',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                onDismissed: (direction) {
                  base.dataStore.deleteTask(task: task);
                },
                key: Key(task.id),
                child: TaskWidget(
                  task: tasks[index],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
