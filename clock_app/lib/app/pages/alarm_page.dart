import 'package:clock_app/app/db/helper/alarm_helper.dart';
import 'package:clock_app/app/model/alarm_info.dart';
import 'package:clock_app/app/utils/theme_data.dart';
import 'package:clock_app/main.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:weekday_selector/weekday_selector.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  late DateTime _alarmTime;
  late String _alarmTimeString;

  List<bool> values = List.filled(7, false);

  late DateTime _alarmDate;
  late String _alarmDateString;
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>>? _alarms;
  late List<AlarmInfo> _currentAlarms = [];
  TextEditingController taskController = TextEditingController();

  @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmDate = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadAlarms();
    });
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Alarm",
            style: TextStyle(
                fontFamily: "avenir",
                fontWeight: FontWeight.w300,
                color: Colors.white,
                fontSize: 24),
          ),
          Expanded(
            child: FutureBuilder<List<AlarmInfo>>(
              future: _alarms,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _currentAlarms = snapshot.data!;
                  return ListView(
                    children: _currentAlarms.map<Widget>((alarm) {
                      var now = alarm.alarmDateTime;
                      var formatedTime = DateFormat("HH:mm aa").format(now!);
                      var gradientColor = GradientTemplate
                          .gradientTemplate[alarm.gradientColorIndex!].colors;

                      return Container(
                        margin: EdgeInsets.only(bottom: 32),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: gradientColor,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          borderRadius: BorderRadius.all(
                            Radius.circular(24),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: gradientColor.last.withOpacity(.4),
                              blurRadius: 8,
                              spreadRadius: 2,
                              offset: Offset(4, 4),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.label,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      alarm.title!,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "avenir"),
                                    ),
                                  ],
                                ),
                                Switch(
                                    value: true,
                                    onChanged: (value) {},
                                    activeColor: Colors.white)
                              ],
                            ),
                            Text(
                              "Mon-Fri",
                              style: TextStyle(
                                fontFamily: "avenir",
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formatedTime,
                                  style: TextStyle(
                                      fontFamily: "avenir",
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 24),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.white,
                                  onPressed: () {
                                    deleteAlarm(alarm.id!);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).followedBy([
                      if (_currentAlarms.length < 5)
                        DottedBorder(
                          strokeWidth: 2,
                          color: CustomColors.clockOutline,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(24),
                          dashPattern: [5, 4],
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: CustomColors.clockBG,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                            ),
                            child: FlatButton(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                              onPressed: () {
                                _alarmTimeString =
                                    DateFormat('HH:mm').format(DateTime.now());
                                _alarmDateString =
                                    DateFormat.yMd().format(DateTime.now());
                                showModalBottomSheet(
                                  useRootNavigator: true,
                                  context: context,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(24),
                                    ),
                                  ),
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: (context, setModalState) {
                                        return Container(
                                          padding: const EdgeInsets.all(32),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  FlatButton(
                                                    onPressed: () async {
                                                      var selectedTime =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime:
                                                            TimeOfDay.now(),
                                                      );
                                                      if (selectedTime !=
                                                          null) {
                                                        final now =
                                                            DateTime.now();
                                                        var selectedDateTime =
                                                            DateTime(
                                                                now.year,
                                                                now.month,
                                                                now.day,
                                                                selectedTime
                                                                    .hour,
                                                                selectedTime
                                                                    .minute);
                                                        _alarmTime =
                                                            selectedDateTime;
                                                        setModalState(() {
                                                          _alarmTimeString =
                                                              DateFormat(
                                                                      'HH:mm')
                                                                  .format(
                                                                      selectedDateTime);
                                                        });
                                                      }
                                                    },
                                                    child: Text(
                                                      _alarmTimeString,
                                                      style: TextStyle(
                                                          fontSize: 32),
                                                    ),
                                                  ),
                                                  //Date Piecker
                                                  // FlatButton(
                                                  //   onPressed: () async {
                                                  //     var selectedDate =
                                                  //         await showDatePicker(
                                                  //       context: context,
                                                  //       firstDate: DateTime(
                                                  //           DateTime.now()
                                                  //                   .year -
                                                  //               5),
                                                  //       initialDate:
                                                  //           _alarmTime == null
                                                  //               ? DateTime.now()
                                                  //               : _alarmTime,
                                                  //       lastDate: DateTime(
                                                  //           DateTime.now()
                                                  //                   .year +
                                                  //               5),
                                                  //       selectableDayPredicate:
                                                  //           (DateTime val) =>
                                                  //               val.weekday ==
                                                  //                           7 ||
                                                  //                       val.weekday ==
                                                  //                           7
                                                  //                   ? false
                                                  //                   : true,
                                                  //     );
                                                  //     _alarmDate =
                                                  //         selectedDate!;
                                                  //     setModalState(
                                                  //       () {
                                                  //         _alarmDateString =
                                                  //             DateFormat('yMd')
                                                  //                 .format(
                                                  //           _alarmDate,
                                                  //         );
                                                  //       },
                                                  //     );
                                                  //   },
                                                  //   child: Text(
                                                  //     _alarmDateString,
                                                  //     style: TextStyle(
                                                  //         fontSize: 28),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        content:
                                                            WeekdaySelector(
                                                                onChanged:
                                                                    (int day) {
                                                                  setState(
                                                                    () {
                                                                      // Set all values to false except the "day"th element
                                                                      values = List.filled(
                                                                          7,
                                                                          false,
                                                                          growable:
                                                                              false)
                                                                        ..[day %
                                                                                7] =
                                                                            true;
                                                                    },
                                                                  );
                                                                },
                                                                values: values),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: ListTile(
                                                  title: Text('Select Days'),
                                                  trailing: Icon(
                                                      Icons.arrow_forward_ios),
                                                ),
                                              ),
                                              ListTile(
                                                title: Text('Repeat'),
                                                trailing: Icon(
                                                    Icons.arrow_forward_ios),
                                              ),
                                              ListTile(
                                                title: Text('Sound'),
                                                trailing: Icon(
                                                    Icons.arrow_forward_ios),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        content: TextField(
                                                          controller:
                                                              taskController,
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText: "Title",
                                                          ),
                                                          onSubmitted: (value) {
                                                            if (value
                                                                .isNotEmpty) {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: ListTile(
                                                  title: Text('Title'),
                                                  trailing: Icon(
                                                      Icons.arrow_forward_ios),
                                                ),
                                              ),
                                              FloatingActionButton.extended(
                                                onPressed: onSaveAlarm,
                                                icon: Icon(Icons.alarm),
                                                label: Text('Save'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                                // scheduleAlarm();
                              },
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/add_alarm.png',
                                    scale: 1.5,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Add Alarm',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'avenir'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      else
                        Center(
                            child: Text(
                          'Only 5 alarms allowed!',
                          style: TextStyle(color: Colors.white),
                        )),
                    ]).toList(),
                  );
                }

                return Center(
                    child: Text(
                  "Loading",
                  style: TextStyle(color: Colors.white),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }

  // DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo
  void scheduleAlarm(
      DateTime scheduleAlarmDateTime, AlarmInfo alarmInfo) async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 10));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound('pop'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(0, 'Office', "Hello",
        scheduledNotificationDateTime, platformChannelSpecifics);
  }

  void onSaveAlarm() {
    DateTime scheduleAlarmDateTime;
    if (_alarmTime.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime.add(Duration(days: 1));

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: _currentAlarms.length,
      title: taskController.text,
    );
    _alarmHelper.insertAlarm(alarmInfo);
    scheduleAlarm(scheduleAlarmDateTime, alarmInfo);
    Navigator.pop(context);
    loadAlarms();
  }

  void deleteAlarm(int id) {
    _alarmHelper.delete(id);
    //unsubscribe for notification
    loadAlarms();
  }
}
