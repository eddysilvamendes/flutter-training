// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/custom_text.dart';
import 'package:food_delivery/widgets/custon_subtitle.dart';
import 'package:food_delivery/widgets/icon_text.dart';

class AppAvaliationColumn extends StatelessWidget {
  final String text;
  AppAvaliationColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitleText(
          text: text,
          size: Dimensions.font26,
        ),
        SizedBox(height: Dimensions.height10),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                (index) => Icon(
                  Icons.star,
                  color: AppColors.mainColor,
                  size: 15,
                ),
              ),
            ),
            SizedBox(width: 10),
            CustomSubTitleText(text: "4.5"),
            SizedBox(width: 10),
            CustomSubTitleText(text: "1287"),
            SizedBox(width: 10),
            CustomSubTitleText(text: "comments")
          ],
        ),
        SizedBox(height: Dimensions.height20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconText(
              icon: Icons.circle_sharp,
              text: "Normal",
              iconColor: AppColors.iconColor1,
            ),
            IconText(
              icon: Icons.location_on,
              text: "1.7km",
              iconColor: AppColors.mainColor,
            ),
            IconText(
              icon: Icons.access_time_filled_rounded,
              text: "32min",
              iconColor: AppColors.iconColor2,
            )
          ],
        ),
      ],
    );
  }
}
