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


const kPrimaryColor = Color(0xff264653);
const kSecondaryColor = Color(0xFFFE9901);
const kContentColorLightTheme = Color(0xFFF5FCF9);
const kContentColorDarkTheme = Color(0xFF1D1D35);
const kWarninngColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);

void pushScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}



