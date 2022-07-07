import 'package:food_delivery/data/repository/order_repo.dart';
import 'package:food_delivery/models/place_order_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController implements GetxService {
  OrderRepo orderRepo;
  OrderController({required this.orderRepo});
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> placeOrder(Function callback, PlaceOrderBody placeOrder) async {
    _isLoading = true;
    Response response = await orderRepo.placeOrder(placeOrder);
    if (response.statusCode == 200) {
      _isLoading = false;
      String message = response.body['message'];
      String orderId = response.body['order_id'].toString();
      callback(true, message, orderId);
    } else {
      print("My status code is " + response.statusText!);
      callback(false, response.statusText, '-1');
    }
  }
}
