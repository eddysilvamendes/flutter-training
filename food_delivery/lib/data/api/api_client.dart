import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeards;

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token = AppConstants.TOKEN;
    _mainHeards = {
      "Content-type": "aplication/json; charset = UTF-8",
      "Authorization": "Bearer $token",
    };
  }
  void updateHader(String token) {
    _mainHeards = {
      "Content-type": "aplication/json; charset = UTF-8",
      "Authorization": "Bearer $token",
    };
  }

  Future<Response> getData(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    print(body.toString());
    try {
      Response response = await post(uri, body, headers: _mainHeards);
      print(response.toString());
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
