import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/custom_text.dart';

class MyButtom extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  const MyButtom(
      {Key? key, required this.text, required this.onTap, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Dimensions.screenWidth / 2,
        height: Dimensions.screenHeight / 13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius15),
          color: color == null ? AppColors.mainColor : color,
        ),
        child: Center(
          child: CustomTitleText(
            text: text,
            size: Dimensions.font20 + Dimensions.font20 / 2,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
