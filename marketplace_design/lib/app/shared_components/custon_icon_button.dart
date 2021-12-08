import 'package:flutter/material.dart';
import 'package:marketplace_design/app/constans/app_constants.dart';

class CustonIconButton extends StatelessWidget {
  const CustonIconButton(
      {this.size = 50,
      this.borderRadius = kBorderRadius,
      required this.icon,
      this.tolltip,
      this.color,
      required this.onPressed,
      Key? key})
      : super(key: key);

  final Icon icon;
  final double size;
  final double borderRadius;
  final String? tolltip;
  final Color? color;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kBorderRadius),
        child: Material(
          color: color ?? Theme.of(context).inputDecorationTheme.fillColor,
          child: IconButton(
            iconSize: size * .4,
            onPressed: onPressed,
            icon: icon,
            tooltip: tolltip,
          ),
        ),
      ),
    );
  }
}
