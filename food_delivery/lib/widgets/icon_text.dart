import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/custon_subtitle.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final Color? textColor;
  final double? size;
  const IconText(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconColor,
      this.size = 12,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.iconSize24,
        ),
        SizedBox(width: 5),
        CustomSubTitleText(
          text: text,
          size: size!,
          color: textColor,
        ),
      ],
    );
  }
}
