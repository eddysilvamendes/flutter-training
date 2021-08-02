import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/models/category.dart';
import 'package:my_second_ecomerce_app/services/category.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> category = [];
  CategoryService _categoryService = CategoryService();

  CategoryProvider.initialize() {
    loadCategory();
  }
  loadCategory() async {
    category = await _categoryService.getCategoryName();
    notifyListeners();
  }
}
