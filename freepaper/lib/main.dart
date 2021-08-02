// @dart=2.9
import 'package:flutter/material.dart';
import 'package:freepaper/screen/home.dart';
import 'package:freepaper/widget/custom.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FreePaper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: white),
      home: HomePage(),
    );
  }
}
