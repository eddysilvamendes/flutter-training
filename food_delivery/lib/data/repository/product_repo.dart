import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

class ProductRepo extends GetxService {
  final ApiClient apiClient; //instance of apiclient

  ProductRepo({required this.apiClient});

  Future<Response> getAllProductList() async {
    return await apiClient.getData(AppConstants.PRODUCT_URI);
  }
}
/*Future<Response> getAllProductList(int id) async {
    return await apiClient.postData(
      AppConstants.PRODUCT_URI,
      {"type_id": id},
    );
  }*/