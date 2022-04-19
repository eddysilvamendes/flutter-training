import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/custom_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  CustomTitleText customTitleText;

  AccountWidget(
      {Key? key, required this.appIcon, required this.customTitleText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: Dimensions.width20,
        top: Dimensions.height10,
        bottom: Dimensions.height10,
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20),
          customTitleText,
        ],
      ),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          blurRadius: 1,
          offset: const Offset(0, 2),
          color: Colors.grey.withOpacity(0.2),
        )
      ]),
    );
  }
}
