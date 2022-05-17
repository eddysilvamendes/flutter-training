import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/product_controller.dart';
import 'package:food_delivery/pages/food/product_food_detail.dart';
import 'package:food_delivery/pages/food/recommended_food_detail.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/custom_text.dart';
import 'package:food_delivery/widgets/custon_subtitle.dart';
import 'package:food_delivery/widgets/icon_text.dart';
import 'package:get/get.dart';

class FoodCategorieList extends StatelessWidget {
  final int pageId;
  final String page;
  final String name;
  const FoodCategorieList(
      {Key? key, required this.pageId, required this.page, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<ProductController>().getProductList();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Categories"),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.widtht30, top: Dimensions.widtht30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomTitleText(text: name),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height15),
                //List of recommended food and images
                GetBuilder<ProductController>(builder: (productController) {
                  return productController.isLoaded
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: productController.productList.length,
                          itemBuilder: (context, index) {
                            if (productController.productList[index].typeId ==
                                pageId) {
                              return GestureDetector(
                                onTap: () => Get.to(() => ProductFoodDetail(
                                      pageId: index,
                                      page: "categories",
                                    )),
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: Dimensions.width20,
                                    right: Dimensions.width20,
                                    bottom: Dimensions.height10,
                                  ),
                                  child: Row(
                                    children: [
                                      //Image Section
                                      Container(
                                        width: Dimensions.listViewImgSize,
                                        height: Dimensions.listViewImgSize,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius20),
                                          color: Colors.white38,
                                          image: const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                "assets/image/food1.png"),
                                            /* NetworkImage(
                                              "http://192.168.1.76:8000/uploads/${productController.productList[index].img}",
                                            ),*/
                                          ),
                                        ),
                                      ),
                                      //Text Section Container
                                      Expanded(
                                        child: Container(
                                          height:
                                              Dimensions.listViewTextContSize,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(
                                                  Dimensions.radius20),
                                              bottomRight: Radius.circular(
                                                  Dimensions.radius20),
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: Dimensions.width10,
                                              right: Dimensions.width10,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CustomTitleText(
                                                  text: productController
                                                      .productList[index].name,
                                                ),
                                                SizedBox(
                                                    height:
                                                        Dimensions.height10),
                                                CustomSubTitleText(
                                                    text:
                                                        "Testing Propose" /*recommendedProduct
                                                .recommendedProductList[index]
                                                .description,*/
                                                    ),
                                                SizedBox(
                                                    height:
                                                        Dimensions.height10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    IconText(
                                                      icon: Icons.circle_sharp,
                                                      text: "Normal",
                                                      iconColor:
                                                          AppColors.iconColor1,
                                                    ),
                                                    IconText(
                                                      icon: Icons.location_on,
                                                      text: "1.7km",
                                                      iconColor:
                                                          AppColors.mainColor,
                                                    ),
                                                    IconText(
                                                      icon: Icons
                                                          .access_time_filled_rounded,
                                                      text: "32min",
                                                      iconColor:
                                                          AppColors.iconColor2,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        )
                      : CircularProgressIndicator(
                          color: AppColors.mainColor,
                        );
                })
              ],
            ),
          ),
        ));
  }
}
