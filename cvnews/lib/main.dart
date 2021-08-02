import 'package:cvnews/screen/home.dart';
import 'package:cvnews/widget/custom.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CVNews',
      theme: ThemeData(
        primaryColor: white,
      ),
      home: HomePage(),
    );
  }
}
