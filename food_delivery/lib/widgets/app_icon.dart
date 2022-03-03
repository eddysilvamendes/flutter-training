// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimension.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color bakcgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;
  final VoidCallback? onTap;

  AppIcon({
    Key? key,
    required this.icon,
    this.bakcgroundColor = const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xFF756d54),
    this.size = 40,
    this.iconSize = 0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size / 2),
            color: bakcgroundColor),
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize == 0 ? Dimensions.iconSize16 : iconSize,
        ),
      ),
    );
  }
}
