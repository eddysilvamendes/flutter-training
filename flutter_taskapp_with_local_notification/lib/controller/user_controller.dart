import 'package:flutter_taskapp_with_local_notification/db/db_helper.dart';
import 'package:flutter_taskapp_with_local_notification/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var userList = <User>[].obs;

  Future<int> addUser({User? user}) async {
    return await DBHelper.inserUser(user);
  }

  void getUser() async {
    List<Map<String, dynamic>> users = await DBHelper.readUser();

    userList.assignAll(users.map((e) => User.fromJson(e)).toList());

    //print(users.toList());
  }

  void deleteUser(User user) {
    DBHelper.deleteUser(user);
    getUser();
  }

  void updateUsers(int id, String username, String email, String about,
      String imgPath) async {
    await DBHelper.updateUser(id, username, email, about, imgPath);
  }
}
