import 'package:flutter/material.dart';
import 'package:flutter_payment_app/component/colors.dart';

class LargeButton extends StatelessWidget {
  final String name;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final bool? isBorder;

  const LargeButton(
      {Key? key,
      required this.name,
      this.backgroundColor: AppColor.mainColor,
      this.textColor,
      this.onTap,
      this.isBorder: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        height: 60,
        width: MediaQuery.of(context).size.width - 60,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: AppColor.mainColor,
          ),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 30,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
