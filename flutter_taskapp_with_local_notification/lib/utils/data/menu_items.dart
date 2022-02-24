import 'package:flutter/material.dart';
import 'package:flutter_taskapp_with_local_notification/utils/menu_items.dart';

class MenuItems {
  static const List<MenuItem> items1 = [itemSetting, itemProfile];
  static const List<MenuItem> items2 = [itemLogOut];

  static const MenuItem itemSetting = MenuItem("Settings", Icons.settings);
  static const MenuItem itemProfile = MenuItem("Add Profile", Icons.person);
  static const MenuItem itemLogOut = MenuItem("Logout", Icons.logout);
}
