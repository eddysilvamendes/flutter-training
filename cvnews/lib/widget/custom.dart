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
Color black87 = Colors.black87;
Color custongrey = Color(0xfff5f8fd);
MaterialColor materialRed = Colors.red;
MaterialColor materialGrey = Colors.grey;

void pushScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

// void pushScreenReplacement(BuildContext context, Widget widget) {
//   Navigator.pushReplacement(
//       context, MaterialPageRoute(builder: (context) => widget));
// }

Widget brandName() {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      children: <TextSpan>[
        TextSpan(
          text: "Wallpaper",
          style: TextStyle(color: black),
        ),
        TextSpan(
          text: "Hub",
          style: TextStyle(color: blue),
        ),
      ],
    ),
  );
}
