// ignore_for_file: prefer_const_constructors

import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/pages/account/account_page.dart';
import 'package:food_delivery/pages/address/add_address_screen.dart';
import 'package:food_delivery/pages/address/pick_address_map.dart';
import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/food/popular_food_detail.dart';
import 'package:food_delivery/pages/food/recommended_food_detail.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/payment/order_success_page.dart';
import 'package:food_delivery/pages/payment/payment_page.dart';
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
  static const String addAddress = "/add-address";
  static const String profileScreen = "/profile-screen";
  static const String pickAddressMap = "/pick-address";
  static const String payment = "/payment";
  static const String orderSuccess = "/order-successful";

  //create function and add it to name of route so we can pass parameter if need
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId = $pageId&page = $page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId = $pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSplashPage() => '$splash';
  static String getSignInPage() => '$signIn';
  static String getAddAddressPage() => "$addAddress";
  static String getAccountScree() => "$profileScreen";
  static String getPickAddressPage() => "$pickAddressMap";
  static String getPaymentPage(String id, int userID) =>
      "$payment?id=$id&userID=$userID";
  static String getOrderSuccess(String orderID, String status) =>
      "$orderSuccess?id=$orderID&status=$status";

  //get list of page to change pages
  static List<GetPage> routes = [
    GetPage(name: profileScreen, page: () => AccountScreen()),
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: initial, page: () => HomePage(), transition: Transition.fade),
    GetPage(
        name: pickAddressMap,
        page: () {
          PickAddressMap _pickAddress = Get.arguments;
          return _pickAddress;
        }),
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
    ),

    GetPage(
      name: addAddress,
      page: () {
        return AddAddressPage();
      },
    ),

    GetPage(
      name: payment,
      page: () => PaymentScreen(
        orderModel: OrderModel(
          id: int.parse(Get.parameters['id']!),
          userId: int.parse(Get.parameters['userID']!),
        ),
      ),
    ),

    GetPage(
        name: orderSuccess,
        page: () => OrderSuccessPage(
              orderID: Get.parameters['id']!,
              status: Get.parameters['status'].toString().contains("success")
                  ? 1
                  : 0,
            )),
  ];
}
