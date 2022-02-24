import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_taskapp_with_local_notification/utils/theme.dart';
import 'package:get/get.dart';

class Utility {
  static imageFromBase64String(
      String base64String, VoidCallback onTap, bool isEdit) {
    return Center(
      child: Stack(
        children: [
          ClipOval(
            child: InkWell(
              onTap: onTap,
              child: Image.memory(
                base64Decode(base64String),
                //fit: BoxFit.fill,

                height: 200,
                //color: Colors.black,
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 15,
            child: Icon(
              isEdit == true ? Icons.add_a_photo : Icons.edit,
              color: Get.isDarkMode ? primaryClr : Colors.black,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
