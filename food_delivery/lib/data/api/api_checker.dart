import 'package:flutter/material.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      Get.offNamed(RouteHelper.getSignInPage());
    } else {
      Get.snackbar(
        response.statusCode.toString(),
        response.statusText!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        borderRadius: Dimensions.radius15,
      );
    }
  }
}
