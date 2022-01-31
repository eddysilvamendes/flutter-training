import 'package:clock_app/app/model/alarm_info.dart';
import 'package:clock_app/app/model/enums.dart';
import 'package:clock_app/app/model/menu_info.dart';
import 'package:clock_app/app/utils/theme_data.dart';

List<MenuInfor> menuItems = [
  MenuInfor(MenuType.clock,
      title: "Clock", imageSource: "assets/clock_icon.png"),
  MenuInfor(MenuType.alarm,
      title: "Alarm", imageSource: "assets/alarm_icon.png"),
  MenuInfor(MenuType.timer,
      title: "Timer", imageSource: "assets/timer_icon.png"),
  MenuInfor(MenuType.stopwatch,
      title: "StopWatch", imageSource: "assets/stopwatch_icon.png"),
];

List<AlarmInfo> alarms = [
  AlarmInfo(
      alarmDateTime: DateTime.now().add(Duration(hours: 1)),
      title: 'Office',
      gradientColorIndex: 0),
  AlarmInfo(
      alarmDateTime: DateTime.now().add(Duration(hours: 2)),
      title: 'Sport',
      gradientColorIndex: 1),
];
