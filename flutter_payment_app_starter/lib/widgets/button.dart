import 'package:flutter/material.dart';
import 'package:flutter_payment_app/component/colors.dart';

class AppButtons extends StatelessWidget {
  final double? fontsize;
  final IconData icon;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final String? text;
  const AppButtons(
      {Key? key,
      this.fontsize = 20,
      required this.icon,
      this.onTap,
      this.backgroundColor: AppColor.mainColor,
      this.iconColor: Colors.white,
      this.textColor: AppColor.mainColor,
      this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: backgroundColor,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 30,
            ),
          ),
          text != null
              ? Text(
                  text!,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
