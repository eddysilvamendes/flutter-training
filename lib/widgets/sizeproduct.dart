import 'package:flutter/material.dart';

class SizeProduct extends StatelessWidget {
  final String size;

  SizeProduct({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      color: Color(0xfff2f2f2),
      child: Center(
        child: Text(
          size,
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
