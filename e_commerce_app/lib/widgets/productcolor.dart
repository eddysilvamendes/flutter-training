import 'package:flutter/material.dart';

class ColorProduct extends StatelessWidget {
  final Color color;

  ColorProduct({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      color: color,
    );
  }
}
