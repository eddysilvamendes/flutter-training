import 'package:flutter/material.dart';

class ColorProduct extends StatelessWidget {
  final Color color;

  ColorProduct({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      color: color,
    );
  }
}
