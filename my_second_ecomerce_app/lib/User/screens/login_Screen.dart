import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/User/widgets/commons.dart';
import 'package:my_second_ecomerce_app/provider/user_provider.dart';
import 'package:my_second_ecomerce_app/User/screens/signUp.dart';
import 'package:my_second_ecomerce_app/User/widgets/changeScreen.dart';
import 'package:my_second_ecomerce_app/User/widgets/loading.dart';
import 'package:my_second_ecomerce_app/User/widgets/myButtons.dart';
import 'package:my_second_ecomerce_app/User/widgets/myTextFormField.dart';
import 'package:my_second_ecomerce_app/User/widgets/passwordTextFormField.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

String pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = RegExp(pattern);

class _LoginState extends State<Login> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  SharedPreferences? preferences;
  bool? loading = false;
  bool? isLogedin = false;
  bool obserText = true;

  void loginValidation() async {
    if (_emailTextController.text.isEmpty &&
        _passwordTextController.text.isEmpty) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Both Flied Are Empty"),
        ),
      );
    } else if (_emailTextController.text.isEmpty) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Email Is Empty"),
        ),
      );
    } else if (!regExp.hasMatch(_emailTextController.text)) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Please Try Vaild Email"),
        ),
      );
    } else if (_passwordTextController.text.isEmpty) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Password Is Empty"),
        ),
      );
    } else if (_passwordTextController.text.length < 6) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Password  Is Too Short"),
        ),
      );
    } else {
      print("Tudu ok no login");
      // submit(context);
    }
  }

  // void submit() async {
  //   if (!await _userProvider.signIn(
  //       _emailTextController.text, _passwordTextController.text)) {
  //     _scaffoldKey.currentState!.showSnackBar(
  //       SnackBar(
  //         content: Text("Sign in Failed"),
  //       ),
  //     );
  //     return;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: user.status == Status.Authenticating
          ? Loading()
          : Stack(
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: grey, blurRadius: 20.0)],
                      ),
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Container(
                                alignment: Alignment.topCenter,
                                child: Image.asset(
                                  "images/logo3.png",
                                  width: 260.0,
                                ),
                              ),
                            ),
                            MyTextFormField(
                              controller: _emailTextController,
                              name: "Email",
                              icon: Icon(Icons.email_outlined),
                            ),
                            PasswordTextFormField(
                              controller: _passwordTextController,
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  obserText = !obserText;
                                });
                              },
                              name: "Password",
                              obserText: obserText,
                            ),
                            LoginButton(
                              imgPath: "images/login2.png",
                              color: blue,
                              name: "Login",
                              onPressed: () async {
                                //loginValidation();
                                if (!await user.signIn(
                                    _emailTextController.text,
                                    _passwordTextController.text)) {
                                  // ignore: deprecated_member_use
                                  _scaffoldKey.currentState!.showSnackBar(
                                    SnackBar(
                                      content: Text("Sign in Failed"),
                                    ),
                                  );
                                  return;
                                }
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Forgot password",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                ChangeScreen(
                                  name: "Create an account",
                                  onTap: () {
                                    pushScreen(context, SignUp());
                                  },
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "or sign in with",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MaterialButton(
                                        onPressed: () {},
                                        child: Image.asset(
                                          "images/googleLogo.png",
                                          width: 40,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
