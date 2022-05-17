import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/pages/food/product_food_detail.dart';
import 'package:food_delivery/pages/food/recommended_food_detail.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/custom_text.dart';
import 'package:food_delivery/widgets/custon_subtitle.dart';
import 'package:food_delivery/widgets/icon_text.dart';
import 'package:get/get.dart';

class FoodListView extends StatelessWidget {
  final int pageId;
  final String url;
  const FoodListView({Key? key, required this.pageId, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<ProductController>().getProductList();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          GetBuilder<ProductController>(
            builder: (popularController) {
              return popularController.isLoaded
                  ? Container(
                      margin: EdgeInsets.only(
                        //left: Dimensions.width20,
                        right: Dimensions.width20,
                        top: Dimensions.height10,
                      ),
                      height: 200,
                      //width: double.maxFinite,
                      //color: Colors.blue,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: popularController.productList.length,
                        itemBuilder: (context, index) {
                          if (popularController.productList[index].typeId ==
                              pageId) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => ProductFoodDetail(
                                      pageId: index,
                                      page: "home",
                                    ));
                                print("tapped " +
                                    popularController.productList[index].id
                                        .toString());
                              },
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: Dimensions.widtht15),
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.white38,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius15),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(url))),
                                  ),
                                  SizedBox(height: 5),
                                  Expanded(
                                    child: Container(
                                      width: 120,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CustomTitleText(
                                            text: popularController
                                                .productList[index].name,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconText(
                                                icon: Icons.monetization_on,
                                                text: popularController
                                                    .productList[index].price
                                                    .toString(),
                                                size: 16,
                                                iconColor: AppColors.mainColor,
                                              ),
                                              IconText(
                                                icon: Icons
                                                    .access_time_filled_rounded,
                                                text: "32min",
                                                iconColor: AppColors.iconColor2,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ))
                  : Container();
            },
          )
        ],
      ),
    );
  }
}
