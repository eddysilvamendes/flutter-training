// ignore_for_file: prefer_const_constructors

import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/pages/food/recommended_food_detail.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  //add name to routes
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String splash = "/splash-page";
  static const String signIn = "/sing-in";

  //create function and add it to name of route so we can pass parameter if need
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId = $pageId&page = $page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId = $pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSplashPage() => '$splash';
  static String getSignInPage() => '$signIn';

  //get list of page to change pages
  static List<GetPage> routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: initial, page: () => HomePage()),
    GetPage(
        name: signIn,
        page: () {
          return SignIpScreen();
        },
        transition: Transition.fade),

    //TODO:FIX THIS
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters["pageId"];
        var page = Get.parameters["page"];
        //print("Get Page id is " + Get.parameters['pageId']!);
        return PopularFoodDetail(
          pageId: int.parse(pageId!),
          page: page!,
        );
      },
      transition: Transition.fadeIn,
    ),
    //TODO: FIX THIS
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'] ?? "2";
        var page = Get.parameters["page"];
        return RecommendedFoodDetail(
          pageId: int.parse(pageId),
          page: page!,
        );
      },
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: cartPage,
      page: () {
        return CartPage();
      },
      transition: Transition.fadeIn,
    )
  ];
}
