// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_taskapp_with_local_notification/screen/theme.dart';
import 'package:flutter_taskapp_with_local_notification/widgets/notification_info.dart';
import 'package:get/get.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  const NotifiedPage({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: _getBGClr(
          int.parse(
            label.toString().split("|")[2],
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Get.isDarkMode ? Colors.black : Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          label.toString().split("|")[0],
          style: TextStyle(
            // ignore: unrelated_type_equality_checks
            color: Get.isDarkMode ? Colors.black : Colors.white,
            /*label.toString().split("|")[2] == 0
                ? whiteClr
                : label.toString().split("|")[2] == 1
                    ? darkGreyClr
                    : whiteClr,*/
          ),
        ),
      ),
      // TODO: tamanho de note e de titulo sa da problema.
      body: Container(
        margin: EdgeInsets.only(top: 25),
        child: Center(
          child: Column(
            children: [
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hello, Freeman",
                    style: subHeadingStyle,
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your have a new reminder",
                    style: titleStyle,
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                  height: MediaQuery.of(context).size.height * 0.60,
                  width: MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _getBGClr(
                      int.parse(
                        label.toString().split("|")[2],
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      NotificationInfo(
                        text: label.toString().split("|")[0],
                        title: "Titulo",
                        icon: Icon(
                          Icons.bookmark,
                          color: Get.isDarkMode ? Colors.black : Colors.white,
                        ),
                      ),
                      NotificationInfo(
                        text: label.toString().split("|")[1],
                        title: "Discrição",
                        icon: Icon(
                          Icons.library_books_outlined,
                          color: Get.isDarkMode ? Colors.black : Colors.white,
                        ),
                      ),
                      NotificationInfo(
                        text: label.toString().split("|")[3],
                        title: "Data",
                        icon: Icon(
                          Icons.date_range,
                          color: Get.isDarkMode ? Colors.black : Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          NotificationInfo(
                            text: label.toString().split("|")[4],
                            title: "Inicio",
                            icon: Icon(
                              Icons.access_time_outlined,
                              color:
                                  Get.isDarkMode ? Colors.black : Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                          NotificationInfo(
                            text: label.toString().split("|")[5],
                            title: "Fim",
                            icon: Icon(
                              Icons.access_time_outlined,
                              color:
                                  Get.isDarkMode ? Colors.black : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
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
}
