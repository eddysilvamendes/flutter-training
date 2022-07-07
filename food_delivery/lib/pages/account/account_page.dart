import 'package:flutter/material.dart';
import 'package:food_delivery/base/custon_loader.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_product_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/pages/address/add_address_screen.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/account_widget.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/custom_text.dart';
import 'package:get/get.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      Get.find<LocationController>().getAddressList();
    }
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: GetBuilder<UserController>(
        builder: (userController) {
          return _userLoggedIn
              ? (userController.isLoading
                  ? Container(
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
                                    customTitleText: CustomTitleText(
                                        text: userController.userModel!.name),
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
                                    customTitleText: CustomTitleText(
                                        text: userController.userModel!.phone),
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
                                    customTitleText: CustomTitleText(
                                        text: userController.userModel!.email),
                                  ),
                                  SizedBox(height: Dimensions.height20),
                                  //Adress Icon
                                  GetBuilder<LocationController>(
                                    builder: (locationController) {
                                      if (_userLoggedIn &&
                                          locationController
                                              .addressList.isEmpty) {
                                        return GestureDetector(
                                          onTap: () => Get.offNamed(
                                              RouteHelper.getAddAddressPage()),
                                          child: AccountWidget(
                                            appIcon: AppIcon(
                                              icon: Icons.location_on,
                                              bakcgroundColor:
                                                  AppColors.yellowColor,
                                              iconColor: Colors.white,
                                              iconSize:
                                                  Dimensions.height10 * 5 / 2,
                                              size: Dimensions.height10 * 5,
                                            ),
                                            customTitleText: CustomTitleText(
                                                text: "Fill in your address"),
                                          ),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () =>
                                              Get.to(() => AddAddressPage()),
                                          child: AccountWidget(
                                            appIcon: AppIcon(
                                              icon: Icons.location_on,
                                              bakcgroundColor:
                                                  AppColors.yellowColor,
                                              iconColor: Colors.white,
                                              iconSize:
                                                  Dimensions.height10 * 5 / 2,
                                              size: Dimensions.height10 * 5,
                                            ),
                                            customTitleText: CustomTitleText(
                                                text: "Your Address"),
                                          ),
                                        );
                                      }
                                    },
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
                                        CustomTitleText(text: "Messages"),
                                  ),
                                  SizedBox(height: Dimensions.height20),
                                  //Message Icon
                                  GestureDetector(
                                    onTap: () {
                                      if (Get.find<AuthController>()
                                          .userLoggedIn()) {
                                        Get.find<AuthController>()
                                            .clearSharedData();
                                        Get.find<CartController>().clear();
                                        Get.find<CartController>()
                                            .clearCartHistory();
                                        Get.find<LocationController>()
                                            .clearAddressList();
                                        Get.offNamed(
                                            RouteHelper.getSignInPage());
                                      } else {
                                        Get.snackbar(
                                            "Error", "You are not Logged in");
                                      }
                                    },
                                    child: AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.logout,
                                        bakcgroundColor: Colors.redAccent,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      customTitleText:
                                          CustomTitleText(text: "Logout"),
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.height20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const CustomLoader())
              : Container(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: Dimensions.height20 * 10,
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/image/signintocontinue.png"))),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(RouteHelper.getSignInPage()),
                        child: Container(
                          width: double.maxFinite,
                          height: Dimensions.height20 * 5,
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                          ),
                          child: Center(
                            child: CustomTitleText(
                              text: "Sign In",
                              color: Colors.white,
                              size: Dimensions.font26,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                );
        },
      ),
    );
  }
}
