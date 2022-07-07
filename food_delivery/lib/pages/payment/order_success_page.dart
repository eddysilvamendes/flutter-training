import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_buttom.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:get/get.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;
  const OrderSuccessPage(
      {Key? key, required this.orderID, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                status == 1
                    ? "assets/image/checked.png"
                    : "assets/image/warning.png",
                width: 100,
                height: 100,
              ),
              SizedBox(
                height: Dimensions.height45,
              ),
              Text(
                status == 1
                    ? 'You placed the order successfully'
                    : "Your order failed",
                style: TextStyle(
                  fontSize: Dimensions.font26,
                ),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.height20,
                    vertical: Dimensions.width20),
                child: Text(
                  status == 1 ? 'Successful Order' : 'Failed order',
                  style: TextStyle(
                      fontSize: Dimensions.font20,
                      color: Theme.of(context).disabledColor),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: Dimensions.height30),
              Padding(
                padding: EdgeInsets.all(Dimensions.height20),
                child: CustomButton(
                  text: "Back to Home",
                  onPressed: () => Get.offAllNamed(
                    RouteHelper.getInitial(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
