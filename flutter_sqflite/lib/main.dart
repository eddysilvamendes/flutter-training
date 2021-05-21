import 'package:flutter/material.dart';
import 'package:flutter_sqflite/pages/home_page.dart';
import 'package:flutter_sqflite/pages/login/login_page.dart';

void main() {
  runApp(MyApp());
}

final routes = {
  '/login': (BuildContext context) => LoginPage(),
  '/home': (BuildContext context) => HomePage(),
  '/': (BuildContext context) => LoginPage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SQFlite App",
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: routes,
    );
  }
}
