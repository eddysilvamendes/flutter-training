// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_product_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/data/repository/product_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/popular_product_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductRepo productRepo;

  ProductController({required this.productRepo});

  List<dynamic> _productList = [];

  List<dynamic> get productList => _productList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getProductList() async {
    Response response = await productRepo.getAllProductList();
    if (response.statusCode == 200) {
      print("Got all product data Data");
      _productList = [];

      _productList.addAll(Product.fromJson(response.body).products);

      _isLoaded = true;
      update(); //more like a set state for UI
    } else {
      print("Could not get products ");
    }
  }
}
