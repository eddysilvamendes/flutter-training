import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/account_widget.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/custom_text.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: CustomTitleText(
          text: "Profile",
          size: Dimensions.iconSize24,
          color: Colors.white,
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(top: Dimensions.height20),
        child: Column(
          children: [
            //Profile Icon
            AppIcon(
              icon: Icons.person,
              bakcgroundColor: AppColors.mainColor,
              iconColor: Colors.white,
              iconSize: Dimensions.height30 + Dimensions.height45,
              size: Dimensions.height15 * 10,
            ),
            SizedBox(height: Dimensions.height30),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //Name Icon
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.person,
                        bakcgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10 * 5 / 2,
                        size: Dimensions.height10 * 5,
                      ),
                      customTitleText: CustomTitleText(text: "Freeman"),
                    ),
                    SizedBox(height: Dimensions.height20),
                    // Phone Icon
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.phone,
                        bakcgroundColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10 * 5 / 2,
                        size: Dimensions.height10 * 5,
                      ),
                      customTitleText: CustomTitleText(text: "599 98 89"),
                    ),
                    SizedBox(height: Dimensions.height20),
                    //Email icon
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.email,
                        bakcgroundColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10 * 5 / 2,
                        size: Dimensions.height10 * 5,
                      ),
                      customTitleText:
                          CustomTitleText(text: "eddysilvamendes19@gmail.com"),
                    ),
                    SizedBox(height: Dimensions.height20),
                    //Adress Icon
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.location_on,
                        bakcgroundColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10 * 5 / 2,
                        size: Dimensions.height10 * 5,
                      ),
                      customTitleText:
                          CustomTitleText(text: "Bairro Craveiro Lopes"),
                    ),
                    SizedBox(height: Dimensions.height20),
                    //Message Icon
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.message_outlined,
                        bakcgroundColor: Colors.redAccent,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10 * 5 / 2,
                        size: Dimensions.height10 * 5,
                      ),
                      customTitleText:
                          CustomTitleText(text: "Flutter developer"),
                    ),
                    SizedBox(height: Dimensions.height20),
                    //Message Icon
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.message_outlined,
                        bakcgroundColor: Colors.redAccent,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height10 * 5 / 2,
                        size: Dimensions.height10 * 5,
                      ),
                      customTitleText:
                          CustomTitleText(text: "Flutter developer"),
                    ),
                    SizedBox(height: Dimensions.height20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
