import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductDBManage {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = "products";
  void uploadProduct({
    required String productName,
    required String productBrand,
    required int productQuantity,
    required String productCategory,
    required List productSizes,
    required List productImages,
    required double productPrice,
  }) {
    var id = Uuid();
    String productId = id.v1();
    _firestore.collection(ref).doc(productId).set({
      "name": productName,
      "id": productId,
      "brand": productBrand,
      "category": productCategory,
      "price": productPrice,
      "quantity": productQuantity,
      "size": productSizes,
      "images": productImages,
    });
  }
}
