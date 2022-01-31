// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationInfo extends StatelessWidget {
  final String text;
  final Icon icon;
  final String title;
  const NotificationInfo(
      {Key? key, required this.text, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              icon,
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 30,
                  color: Get.isDarkMode ? Colors.black : Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Row(
            children: [
              Text(
                text,
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.black : Colors.white,
                    fontSize: 18),
              ),
            ],
          )
        ],
      ),
    );
  }
}
