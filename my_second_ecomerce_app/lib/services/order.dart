import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:my_second_ecomerce_app/models/cart_item.dart';
import 'package:my_second_ecomerce_app/models/order.dart';

class OrderServices {
  String collection = "orders";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createOrder(
      {String? userId,
      String? id,
      String? description,
      String? status,
      List<CartItemModel>? cart,
      int? totalPrice}) {
    List<Map> convertedCart = [];

    for (CartItemModel item in cart!) {
      convertedCart.add(item.toMap());
    }

    _firestore.collection(collection).doc(id).set({
      "userId": userId,
      "id": id,
      "cart": convertedCart,
      "total": totalPrice,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "description": description,
      "status": status
    });
  }

  Future<List<OrderModel>> getUserOrders({String? userId}) async => _firestore
          .collection(collection)
          .where("userId", isEqualTo: userId)
          .get()
          .then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot order in result.docs) {
          orders.add(OrderModel.fromSnapshot(order));
        }
        return orders;
      });

  Future<List<OrderModel>> getOrder() async =>
      _firestore.collection(collection).get().then((result) {
        List<OrderModel> order = [];
        for (DocumentSnapshot product in result.docs) {
          order.add(OrderModel.fromSnapshot(product));
        }
        return order;
      });
}
