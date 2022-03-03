import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimension.dart';

class CustomTitleText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  CustomTitleText(
      {Key? key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.size = 0,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size == 0 ? Dimensions.font20 : size,
        fontWeight: FontWeight.w400,
        fontFamily: "Roboto",
      ),
      overflow: overflow,
    );
  }
}
