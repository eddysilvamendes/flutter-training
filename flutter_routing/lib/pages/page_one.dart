import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  String title;

  PageOne(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(title),
      ),
    );
  }
}
