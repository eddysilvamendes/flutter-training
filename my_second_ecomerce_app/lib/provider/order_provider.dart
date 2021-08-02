import 'package:flutter/cupertino.dart';
import 'package:my_second_ecomerce_app/models/order.dart';
import 'package:my_second_ecomerce_app/services/order.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> order = [];
  OrderServices _orderServices = OrderServices();

  OrderProvider.initialize() {
    loadOrder();
  }

  loadOrder() async {
    order = await _orderServices.getOrder();
    notifyListeners();
  }
}
