import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_product_controller.dart';
import 'package:food_delivery/controllers/categories_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/categories/food_categories.dart';

import 'package:food_delivery/pages/food/recommended_food_detail.dart';

import 'package:food_delivery/helper/dependencies.dart' as dep;
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/splash/splash_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
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
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Loisirs Delivery',
                home: SignIpScreen(),
                //initialRoute: RouteHelper.getSplashPage(),
                // getPages: RouteHelper.routes,
              );
            },
          );
        },
      );
    });
  }
}
