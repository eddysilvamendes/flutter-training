import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_second_ecomerce_app/models/category.dart';
import 'package:my_second_ecomerce_app/models/product.dart';

class CategoryService {
  String collection = "products";
  String field = "category";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<ProductModel>> getCategory() async =>
      _firestore.collection(collection).where(field).get().then((result) {
        List<ProductModel> category = [];
        for (DocumentSnapshot product in result.docs) {
          category.add(ProductModel.fromSnapshot(product));
        }
        return category;
      });

  Future<List<CategoryModel>> getCategoryName() async =>
      _firestore.collection("category").get().then((result) {
        List<CategoryModel> categoryName = [];
        for (DocumentSnapshot categoryname in result.docs) {
          categoryName.add(CategoryModel.fromSnapshot(categoryname));
        }
        return categoryName;
      });
}
