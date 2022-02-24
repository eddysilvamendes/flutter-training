// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_taskapp_with_local_notification/screen/home_screen.dart';
import 'package:flutter_taskapp_with_local_notification/utils/theme.dart';
import 'package:flutter_taskapp_with_local_notification/widgets/button.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Add all your task and get the notification",
            body:
                "Create your task and personalize it with color and notification time",
            image: buildImage("images/task2.png"),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: "Organize all your day and plan",
            body:
                "With the task app its easy to organize your day or week play. Say no more to stress",
            image: buildImage("images/task7.png"),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: "Keep it happy, sucessfuly and relaxed",
            body:
                "With organize task daily task your are will feel relazed and your performace will increase",
            footer: MyButton(
              label: "Start Task",
              onTap: () {
                Get.off(() => HomeScreen());
              },
            ),
            image: buildImage("images/task8.png"),
            decoration: getPageDecoration(),
          ),
        ],
        done: Text(
          "Read",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        showSkipButton: true,
        skip: Text("Skip"),
        next: Icon(Icons.arrow_forward),
        skipColor: Colors.red,
        doneColor: Colors.green,
        nextColor: Colors.blue,
        dotsDecorator: getDotDecoration(),
        globalBackgroundColor: Theme.of(context).backgroundColor,
        onDone: () {
          Get.off(() => HomeScreen());
        },
      ),
    );
  }

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
        descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.white,
      );

  DotsDecorator getDotDecoration() => DotsDecorator(
      color: Color(0xFFBDBDBD),
      activeColor: primaryClr,
      size: Size(10, 10),
      activeSize: Size(20, 10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ));
}
