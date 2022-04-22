import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

class CategoriesRepo extends GetxService {
  final ApiClient apiClient; //instance of apiclient

  CategoriesRepo({required this.apiClient});

  Future<Response> getCategoriesList() async {
    return await apiClient.getData(AppConstants.CATEGORIES_URI);
  }
}
