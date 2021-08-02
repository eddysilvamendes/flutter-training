import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/User/widgets/commons.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;

  // name constructor that has a positional parameters with the text required
  // and the other parameters optional
  CustomText({this.text, this.size, this.color, this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          fontSize: size ?? 16,
          color: color ?? black,
          fontWeight: weight ?? FontWeight.normal),
    );
  }
}
