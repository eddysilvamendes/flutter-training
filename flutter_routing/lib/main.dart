import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_routing/pages/home_page.dart';
import 'package:flutter_routing/pages/page_one.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          primaryColor: defaultTargetPlatform == TargetPlatform.iOS
              ? Colors.grey[50]
              : null),
      home: HomePage(),
      /*  routes: <String, WidgetBuilder>{
          "/a": (BuildContext context) => PageOne("Page One"),
        } */
    );
  }
}
