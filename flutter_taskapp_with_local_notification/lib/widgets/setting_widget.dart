// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';

import 'package:flutter_taskapp_with_local_notification/screen/profile/profile_screen.dart';

import 'package:flutter_taskapp_with_local_notification/services/theme_service.dart';
import 'package:flutter_taskapp_with_local_notification/utils/theme.dart';
import 'package:get/get.dart';

const keyLanguage = "key-language";
const keyLocation = "key-location";
const keyPassoword = "key-password";

Widget buildContent(
        {VoidCallback? ontap,
        required String name,
        required IconData icon,
        required Color color,
        required Widget child}) =>
    InkWell(
      onTap: ontap,
      child: Row(
        children: [
          iconWidget(
            icon,
            color,
          ),
          SizedBox(width: 10),
          Text(
            name,
            style: titleStyle,
          ),
          SizedBox(width: 10),
          child,
        ],
      ),
    );

Widget iconWidget(IconData icon, Color color) => Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
