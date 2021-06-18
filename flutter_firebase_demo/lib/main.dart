import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_demo/Navigation/navigation_drawer.dart';
// ignore: unused_import
import 'package:flutter_firebase_demo/Wallpaper/wall_screen.dart';
import 'package:flutter_firebase_demo/pages/home_creen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text("FireBase App"),
        ),
        body: HomeScreen(),
      ),
    );
  }
}
