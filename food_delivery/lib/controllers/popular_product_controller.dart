// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_product_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/popular_product_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;
  late CartController _cartController;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print("Got Data");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update(); //more like a set state for UI
    } else {
      print("Could not get products recommended");
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        "Error",
        "Quantity can't be less then 0",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        icon: Icon(
          Icons.warning,
          color: Colors.red,
        ),
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if (_inCartItems + quantity > 20) {
      Get.snackbar(
        "Error",
        "Your cant Add mode",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        icon: Icon(
          Icons.warning,
          color: Colors.red,
        ),
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductsModel product, CartController cartController) {
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cartController;
    var exist = false;
    exist = _cartController.existInCart(product);
    print(exist.toString());
    //get from storage and set it in cartItems
    if (exist) {
      _inCartItems = _cartController.getQuantity(product);
    }
    print("quantiti" + _inCartItems.toString());
  }

  void addItem(ProductsModel product) {
    _cartController.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cartController.getQuantity(product);
    _cartController.item.forEach((key, value) {
      print("The id is " +
          value.id.toString() +
          "The quantity is " +
          value.quantity.toString());
    });
    update();
  }

  int get totalItems {
    return _cartController.totalItems;
  }

  List<CartModel> get getItems {
    return _cartController.getItems;
  }
}
