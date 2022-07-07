// ignore_for_file: prefer_const_constructors

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/categories_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/pages/categories/food_categories_list.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/pages/food/product_food_detail.dart';
import 'package:food_delivery/pages/food/recommended_food_detail.dart';
import 'package:food_delivery/widgets/food_horizontal_list.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/app_avaliation_collum.dart';
import 'package:food_delivery/widgets/custom_text.dart';
import 'package:food_delivery/widgets/custon_subtitle.dart';
import 'package:food_delivery/widgets/icon_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<ProductController>().getProductList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //slider section
        GetBuilder<PopularProductController>(builder: (popularProduct) {
          return popularProduct.isLoaded
              ? Container(
                  height: Dimensions.pageView,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: popularProduct.popularProductList.length,
                    itemBuilder: (context, index) {
                      return _buildPageItem(
                          index, popularProduct.popularProductList[index]);
                    },
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                );
        }),
        //dots
        Center(
          child:
              GetBuilder<PopularProductController>(builder: (popularProduct) {
            return DotsIndicator(
              dotsCount: popularProduct.popularProductList.isEmpty
                  ? 1
                  : popularProduct.popularProductList.length,
              position: _currentPageValue,
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            );
          }),
        ),
        SizedBox(height: Dimensions.height30),
        Container(
          margin: EdgeInsets.only(left: Dimensions.widtht30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomTitleText(text: "Categories"),
            ],
          ),
        ),
        //Categorie Section
        SizedBox(height: Dimensions.height10),
        GetBuilder<CategoriesController>(
          builder: (categorieController) {
            return Container(
              margin: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              height: Dimensions.height30 + Dimensions.height20,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                //physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: categorieController.categoriesList.length,

                itemBuilder: (context, index) {
                  var categories = categorieController.categoriesList[index];
                  return GestureDetector(
                    onTap: () {
                      print("tapped " + categories.id.toString());
                      Get.to(() => FoodCategorieList(
                            pageId: categories.id,
                            page: "foodpage",
                            name: categories.title,
                          ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        right: Dimensions.width10,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: Dimensions.height20 * 2,
                      child: Center(
                        child: CustomTitleText(
                          text: categorieController.categoriesList[index].title,
                          color: Colors.white,
                          //size: Dimensions.font16,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),

        //Popular text
        SizedBox(height: Dimensions.height30),
        Container(
          margin: EdgeInsets.only(
              left: Dimensions.width20, top: Dimensions.width20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomTitleText(text: "Popular"),
            ],
          ),
        ),
        FoodListView(pageId: 2, url: "assets/image/food12.png"),
        //Recommended Setion
        SizedBox(height: Dimensions.height10),
        Container(
          margin: EdgeInsets.only(
              left: Dimensions.width20, top: Dimensions.width20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomTitleText(text: "Recommended"),
            ],
          ),
        ),
        FoodListView(pageId: 3, url: "assets/image/food1.png"),
        //FastFood Setion
        SizedBox(height: Dimensions.height10),
        Container(
          margin: EdgeInsets.only(
              left: Dimensions.width20, top: Dimensions.width20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomTitleText(text: "FastFood"),
            ],
          ),
        ),
        FoodListView(pageId: 5, url: "assets/image/food0.png"),
        //Noodles Section
        SizedBox(height: Dimensions.height10),
        Container(
          margin: EdgeInsets.only(
              left: Dimensions.width20, top: Dimensions.width20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomTitleText(text: "Noodles"),
            ],
          ),
        ),
        FoodListView(pageId: 4, url: "assets/image/food13.png"),
        SizedBox(height: Dimensions.height30)

        /*
        Container(
          margin: EdgeInsets.only(left: Dimensions.widtht30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomTitleText(text: "Recommended"),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: CustomTitleText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: CustomSubTitleText(
                  text: "Food pairing",
                ),
              )
            ],
          ),
        ),
        //List of recommended food and images
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProduct.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Get.to(() => RecommendedFoodDetail(
                            pageId: index,
                            page: "home",
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
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white38,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/image/food1.png")
                                    /*NetworkImage(
                                    AppConstants.BASE_URL +
                                        AppConstants.UPLOAD_URL +
                                        recommendedProduct
                                            .recommendedProductList[index].img,
                                  ),*/
                                    ),
                              ),
                            ),
                            //Text Section Container
                            Expanded(
                              child: Container(
                                height: Dimensions.listViewTextContSize,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(Dimensions.radius20),
                                    bottomRight:
                                        Radius.circular(Dimensions.radius20),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomTitleText(
                                        text: recommendedProduct
                                            .recommendedProductList[index].name,
                                      ),
                                      SizedBox(height: Dimensions.height10),
                                      CustomSubTitleText(
                                          text:
                                              "Testing Propose" /*recommendedProduct
                                            .recommendedProductList[index]
                                            .description,*/
                                          ),
                                      SizedBox(height: Dimensions.height10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        })
      */
      ],
    );
  }

  Widget _buildPageItem(int index, popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currentScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => PopularFoodDetail(
                    pageId: index,
                    page: "home",
                  ));
              print(index.toString());
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: //AssetImage("assets/image/food0.png"),
                      NetworkImage(
                    AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URL +
                        popularProduct.img,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                left: Dimensions.widtht30,
                right: Dimensions.widtht30,
                bottom: Dimensions.height30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height15,
                  left: Dimensions.height15,
                  right: Dimensions.height15,
                ),
                child: AppAvaliationColumn(
                  text: popularProduct.name,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
