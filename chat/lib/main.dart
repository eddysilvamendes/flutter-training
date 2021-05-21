import 'package:flutter/material.dart';
import 'package:chat/pages/home_page.dart';

void main() {
  runApp(MyChat());
}

class MyChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat APP',
      home: HomePage(),
    );
  }
}
