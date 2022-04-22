import 'package:flutter/material.dart';

class CustomSubTitleText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double heigh;
  CustomSubTitleText(
      {Key? key,
      this.color = const Color(0xFFccc7c5),
      required this.text,
      this.size = 12,
      this.heigh = 1.2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(
        color: color,
        fontSize: size,
        height: heigh,
        fontFamily: "Roboto",
      ),
      //overflow: TextOverflow.ellipsis,
    );
  }
}
