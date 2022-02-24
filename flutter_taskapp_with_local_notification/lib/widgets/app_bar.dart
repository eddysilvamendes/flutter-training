// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar buildAppBar(BuildContext context) {
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
  );
}
