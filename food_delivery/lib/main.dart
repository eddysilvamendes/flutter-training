import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_product_controller.dart';
import 'package:food_delivery/controllers/categories_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/helper/dependencies.dart' as dep;
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<CategoriesController>(builder: (_) {
      return GetBuilder<PopularProductController>(
        builder: (_) {
          return GetBuilder<RecommendedProductController>(
            builder: (_) {
              return GetBuilder<ProductController>(
                builder: (_) {
                  return GetMaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Loisirs Delivery',
                    //home: AddAddressPage(),
                    initialRoute: RouteHelper.getSplashPage(),
                    getPages: RouteHelper.routes,
                    theme: ThemeData(
                      primaryColor: AppColors.mainColor,
                      fontFamily: "Lato",
                    ),
                  );
                },
              );
            },
          );
        },
      );
    });
  }
}
