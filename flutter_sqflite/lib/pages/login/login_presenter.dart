import 'package:flutter_sqflite/data/rest_data.dart';
import 'package:flutter_sqflite/models/user.dart';

abstract class LoginPageContract {
  void onLoginSucess(User user);
  void onLoginError(String error);
}

class LoginPagePresenter {
  LoginPageContract _view;
  RestData api = RestData();
  LoginPagePresenter(this._view);

  doLogin(String username, String password) {
    api
        .login(username, password)
        .then((user) => _view.onLoginSucess(user))
        .catchError((onError) => _view.onLoginError(onError));
  }
}
