import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/models/singUp_body.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(
      AppConstants.REGISTRATION_URI,
      signUpBody.toJson(),
    );
  }

  Future<Response> login(String email, String password) async {
    return await apiClient.postData(
      AppConstants.LOGIN_URI,
      {"email": email, "password": password},
    );
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {
      throw e;
    }
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.TOKEN) ?? "None";
  }
}
