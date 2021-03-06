import 'package:flutter/material.dart';
import 'package:whats_app_ui_clone/pages/whatapp_home.dart';
import 'package:camera/camera.dart';
import 'dart:async';

List<CameraDescription> cameras;

Future<Null> main() async {
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WhatsApp",
      theme: ThemeData(
        primaryColor: Color(0xff075E54),
        accentColor: Color(0xff250D366),
      ),
      debugShowCheckedModeBanner: false,
      home: WhatsAppHome(cameras),
    );
  }
}
