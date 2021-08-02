import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/models/product.dart';
import 'package:my_second_ecomerce_app/services/category.dart';
import 'package:my_second_ecomerce_app/services/product.dart';

class UserProductProvider with ChangeNotifier {
  List<ProductModel> product = [];
  List<ProductModel> productsByCategory = [];
  List<ProductModel> productSearch = [];
  List<ProductModel> featured = [];
  List<ProductModel> sales = [];
  List<ProductModel> quantity = [];
  ProductService _productService = ProductService();

  UserProductProvider.initialize() {
    loadProducts();
    loadFeatured();
    loadSales();
  }

  loadProducts() async {
    product = await _productService.getProducts();
    notifyListeners();
  }

  loadFeatured() async {
    featured = await _productService.getFeatured();
    notifyListeners();
  }

  loadSales() async {
    sales = await _productService.getSales();
    notifyListeners();
  }

  Future loadquantity() async {
    quantity = await _productService.getSales();

    notifyListeners();
  }

  Future loadCategory({required String categoryName}) async {
    productsByCategory =
        await _productService.getProductsOfCategory(category: categoryName);
    notifyListeners();
  }

  Future search({required String productName}) async {
    productSearch =
        await _productService.searchProducts(productName: productName);
    notifyListeners();
  }
}
