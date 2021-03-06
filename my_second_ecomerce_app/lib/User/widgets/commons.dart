import 'package:flutter/material.dart';

Color deepOrange = Colors.deepOrange;
Color black = Colors.black;
Color red = Colors.red;
Color grey = Colors.grey;
Color pink = Colors.pink;
Color white = Colors.white;
Color blue = Colors.blue;
Color redShade900 = Colors.red.shade900;
Color amber = Colors.amber;
Color green = Colors.green;
MaterialColor materialRed = Colors.red;
MaterialColor materialGrey = Colors.grey;

void pushScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void pushScreenReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}
