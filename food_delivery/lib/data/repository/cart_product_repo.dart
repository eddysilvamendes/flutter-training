import 'dart:convert';

import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    //sharedPreferences.remove(AppConstants.CARTKEY);
    //sharedPreferences.remove(AppConstants.CART_HISTORY_KEY);
    var time = DateTime.now().toString();
    cart = [];

    //Convert object to string cuz sharedPreference only take Strings
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CARTKEY, cart);
    //print(sharedPreferences.getStringList(AppConstants.CARTKEY));
  }

  List<CartModel> getCartList() {
    List<CartModel> cartList = [];
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CARTKEY)) {
      carts = sharedPreferences.getStringList(AppConstants.CARTKEY)!;
    }

    carts.forEach((element) => cartList.add(
          CartModel.fromJson(
            jsonDecode(element),
          ),
        ));

    return cartList;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_KEY)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_KEY)!;
    }
    for (int i = 0; i < cart.length; i++) {
      //print("History list " + cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_KEY, cartHistory);
    print("The lenght is " + getHistoryList().length.toString());
    for (int j = 0; j < getHistoryList().length; j++) {
      print("The Time is " + getHistoryList()[j].time.toString());
    }
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CARTKEY);
  }

  List<CartModel> getHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_KEY)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_KEY)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach(
      (element) => cartListHistory.add(
        CartModel.fromJson(
          jsonDecode(element),
        ),
      ),
    );
    return cartListHistory;
  }

  void clearCartHistory() {
    removeCart();
    cartHistory = [];
    sharedPreferences.remove(AppConstants.CART_HISTORY_KEY);
  }
}
