import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/world_clock/pages/clock_home_screen.dart';
import 'package:flutter_firebase_demo/world_clock/pages/world_loading_screen.dart';
import 'package:flutter_firebase_demo/world_clock/pages/world_location_screen.dart';

class ClockMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/location': (context) => Location(),
      },
    );
  }
}
