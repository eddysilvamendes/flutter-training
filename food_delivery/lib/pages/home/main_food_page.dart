// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:food_delivery/base/custon_loader.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/categories_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/custom_text.dart';
import 'package:food_delivery/widgets/custon_subtitle.dart';
import 'package:get/get.dart';

class MainFoodPage extends StatefulWidget {
  MainFoodPage({Key? key}) : super(key: key);

  @override
  _MainFoodPageState createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
    await Get.find<CategoriesController>().getCategoriesList();
    await Get.find<ProductController>().getProductList();
    await Get.find<UserController>().getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return RefreshIndicator(
      child: Column(
        children: [
          //header
          GetBuilder<UserController>(builder: (userController) {
            return _userLoggedIn
                ? userController.isLoading
                    ? Container(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: Dimensions.height45,
                              bottom: Dimensions.height15),
                          padding: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTitleText(
                                    text: "Cheff",
                                    color: AppColors.mainColor,
                                  ),
                                  Row(
                                    children: [
                                      CustomSubTitleText(
                                        text: userController.userModel!.name,
                                        color: Colors.black54,
                                      ),
                                      Icon(Icons.arrow_drop_down_rounded)
                                    ],
                                  )
                                ],
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: Dimensions.height45,
                                    height: Dimensions.height45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius15),
                                      color: AppColors.mainColor,
                                    ),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                      size: Dimensions.iconSize24,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const CustomLoader()
                : Container(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: Dimensions.height45,
                          bottom: Dimensions.height15),
                      padding: EdgeInsets.only(
                          left: Dimensions.width20, right: Dimensions.width20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTitleText(
                                text: "Cheff",
                                color: AppColors.mainColor,
                              ),
                              Row(
                                children: [
                                  CustomSubTitleText(
                                    text: "Cocking",
                                    color: Colors.black54,
                                  ),
                                  Icon(Icons.arrow_drop_down_rounded)
                                ],
                              )
                            ],
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                width: Dimensions.height45,
                                height: Dimensions.height45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius15),
                                  color: AppColors.mainColor,
                                ),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: Dimensions.iconSize24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          }),
          //body
          Expanded(
            child: SingleChildScrollView(
              child: FoodPageBody(),
            ),
          ),
        ],
      ),
      onRefresh: _loadResources,
    );
  }
}
