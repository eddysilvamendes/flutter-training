// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery/base/no_data.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_product_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/models/place_order_model.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/pages/food/recommended_food_detail.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/custom_text.dart';
import 'package:food_delivery/widgets/custon_subtitle.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Icons section
          Positioned(
            left: Dimensions.width20,
            right: Dimensions.width20,
            top: Dimensions.height20 * 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back,
                  iconColor: Colors.white,
                  bakcgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                  onTap: () => Get.toNamed(RouteHelper.getInitial()),
                ),
                SizedBox(width: Dimensions.width20 * 5),
                AppIcon(
                  icon: Icons.home_outlined,
                  iconColor: Colors.white,
                  bakcgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                  onTap: () => Get.toNamed(RouteHelper.getInitial()),
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: Colors.white,
                  bakcgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
              ],
            ),
          ),
          //Content section
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItems.length > 0
                ? Positioned(
                    top: Dimensions.height20 * 5,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    bottom: 0,
                    child: Container(
                      child: GetBuilder<CartController>(
                        builder: (controller) {
                          var _cartList = controller.getItems;
                          return ListView.builder(
                            itemCount: _cartList.length,
                            itemBuilder: (_, index) {
                              return Container(
                                height: Dimensions.height20 * 5,
                                width: double.maxFinite,
                                //margin: EdgeInsets.only(bottom: Dimensions.height10),
                                child: Row(
                                  children: [
                                    //Image Section
                                    GestureDetector(
                                      onTap: () {
                                        var popularIndex =
                                            Get.find<PopularProductController>()
                                                .popularProductList
                                                .indexOf(
                                                    _cartList[index].product);

                                        if (popularIndex >= 0) {
                                          Get.to(
                                            () => PopularFoodDetail(
                                                pageId: popularIndex,
                                                page: "cartpage"),
                                          );
                                        } else {
                                          var recommendedIndex = Get.find<
                                                  RecommendedProductController>()
                                              .recommendedProductList
                                              .indexOf(
                                                  _cartList[index].product);
                                          if (recommendedIndex < 0) {
                                            Get.snackbar(
                                              "History Product",
                                              "Product review is not availeble for history product",
                                              //backgroundColor: Colors.red,
                                              //colorText: Colors.white,
                                              snackPosition: SnackPosition.TOP,
                                            );
                                          } else {
                                            Get.to(
                                              () => RecommendedFoodDetail(
                                                  pageId: recommendedIndex,
                                                  page: "cartpage"),
                                            );
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: Dimensions.height20 * 5,
                                        height: Dimensions.height20 * 5,
                                        margin: EdgeInsets.only(
                                            bottom: Dimensions.height10),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                AppConstants.BASE_URL +
                                                    AppConstants.UPLOAD_URL +
                                                    controller
                                                        .getItems[index].img!),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    //Content Secion
                                    SizedBox(width: Dimensions.width10),
                                    Expanded(
                                      child: Container(
                                        height: Dimensions.height20 * 5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CustomTitleText(
                                              text: controller
                                                  .getItems[index].name!,
                                              color: Colors.black54,
                                            ),
                                            CustomSubTitleText(text: "Spicy"),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomTitleText(
                                                  text:
                                                      "\$ ${controller.getItems[index].price.toString()}",
                                                  color: Colors.red,
                                                ),
                                                //Quantity bottom section
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    top: Dimensions.height10,
                                                    bottom: Dimensions.height10,
                                                    left: Dimensions.width10,
                                                    right: Dimensions.width10,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      Dimensions.radius20,
                                                    ),
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: AppColors
                                                              .signColor,
                                                        ),
                                                        onTap: () {
                                                          controller.addItem(
                                                              _cartList[index]
                                                                  .product!,
                                                              -1);
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: Dimensions
                                                                  .width10 /
                                                              2),
                                                      CustomTitleText(
                                                          text: _cartList[index]
                                                              .quantity
                                                              .toString()),
                                                      SizedBox(
                                                          width: Dimensions
                                                                  .width10 /
                                                              2),
                                                      GestureDetector(
                                                        child: Icon(Icons.add,
                                                            color: AppColors
                                                                .signColor),
                                                        onTap: () {
                                                          controller.addItem(
                                                              _cartList[index]
                                                                  .product!,
                                                              1);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  )
                : NoDataScreen(text: "Your cart is empty!");
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartProduct) {
          return Container(
            height: Dimensions.bottomHeightbar,
            padding: EdgeInsets.only(
              top: Dimensions.height20,
              bottom: Dimensions.height20,
              left: Dimensions.width20,
              right: Dimensions.width20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(
                  Dimensions.radius20 * 2,
                ),
                topLeft: Radius.circular(
                  Dimensions.radius20 * 2,
                ),
              ),
              color: AppColors.buttonBackgroundColor,
            ),
            child: cartProduct.getItems.length > 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //quantity button container
                      Container(
                        padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius20,
                          ),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: Dimensions.width10 / 2),
                            CustomTitleText(
                                text:
                                    "\$ " + cartProduct.totalAmount.toString()),
                            SizedBox(width: Dimensions.width10 / 2),
                          ],
                        ),
                      ),
                      //add to card container
                      GestureDetector(
                        onTap: () {
                          //cartProduct.addToHistory();
                          /* if (Get.find<AuthController>().userLoggedIn()) {
                            cartProduct.addToHistory();
                            if (Get.find<LocationController>()
                                .addressList
                                .isEmpty) {
                              Get.toNamed(RouteHelper.getAddAddressPage());
                            } else {
                              //Get.off(RouteHelper.getInitial());
                              Get.offNamed(RouteHelper.getPaymentPage("100001",
                                  Get.find<UserController>().userModel!.id));
                            }
                          } else {
                            Get.toNamed(RouteHelper.getSignInPage());
                          }*/
                          if (Get.find<AuthController>().userLoggedIn()) {
                            var location =
                                Get.find<LocationController>().getUserAddress();
                            var cart = Get.find<CartController>().getItems;
                            var user = Get.find<UserController>().userModel;
                            PlaceOrderBody placeOrder = PlaceOrderBody(
                              cart: cart,
                              orderAmount: 100.0,
                              orderNote: "Note About the food",
                              address: location.address,
                              latitude: location.latitude,
                              longitude: location.longitude,
                              contactPersonName: user!.name,
                              contactPersonNumber: user.phone,
                              distance: 10.0,
                              scheduleAt: '',
                            );

                            Get.find<OrderController>()
                                .placeOrder(_callBack, placeOrder);
                          } else {
                            Get.toNamed(RouteHelper.getSignInPage());
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height20,
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.mainColor,
                          ),
                          child: CustomTitleText(
                            text: " Check Out",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          );
        },
      ),
    );
  }

  void _callBack(bool isSuccess, String message, String orderID) {
    if (isSuccess) {
      Get.offNamed(
        RouteHelper.getPaymentPage(
            orderID, Get.find<UserController>().userModel!.id),
      );
    } else {
      Get.snackbar("Error", message, snackPosition: SnackPosition.BOTTOM);
    }
  }
}
