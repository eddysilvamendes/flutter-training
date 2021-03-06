import 'package:flutter/material.dart';
import 'package:flutter_sqflite/data/database_helper.dart';
import 'package:flutter_sqflite/models/user.dart';
import 'package:flutter_sqflite/pages/login/login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();

  String _username, _password;

  LoginPagePresenter _presenter;

  _LoginPageState() {
    _presenter = LoginPagePresenter(this);
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_username, _password);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldkey.currentState.showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = RaisedButton(
      onPressed: _submit,
      child: Text("Login"),
      color: Colors.green,
    );
    var loginForm = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "SQFlite APp Login",
          textScaleFactor: 2.0,
        ),
        Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: InputDecoration(labelText: "Username"),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: InputDecoration(labelText: "Password"),
                ),
              ),
            ],
          ),
        ),
        loginBtn
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      key: scaffoldkey,
      body: Container(
        child: Center(
          child: loginForm,
        ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSucess(User user) async {
    // TODO: implement onLoginSucess

    _showSnackBar(user.toString());
    setState(() {
      _isLoading = false;
    });
    var db = DatabaseHelper();
    await db.saveUser(user);
    Navigator.of(context).pushNamed("/home");
  }
}
