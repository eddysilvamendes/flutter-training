import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Text(
          "HomeScreen",
          style: TextStyle(
            fontSize: 40.0,
          ),
        ),
      ),
    );
  }
}
