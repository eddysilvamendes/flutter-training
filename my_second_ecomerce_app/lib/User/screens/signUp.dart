import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_second_ecomerce_app/provider/user_provider.dart';
import 'package:my_second_ecomerce_app/User/widgets/commons.dart';
import 'package:my_second_ecomerce_app/services/user.dart';
import 'package:my_second_ecomerce_app/User/screens/homePage.dart';
import 'package:my_second_ecomerce_app/User/widgets/changeScreen.dart';
import 'package:my_second_ecomerce_app/User/widgets/loading.dart';
import 'package:my_second_ecomerce_app/User/widgets/myButtons.dart';
import 'package:my_second_ecomerce_app/User/widgets/myTextFormField.dart';
import 'package:my_second_ecomerce_app/User/widgets/passwordTextFormField.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final TextEditingController email = TextEditingController();
final TextEditingController userName = TextEditingController();
final TextEditingController phoneNumber = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController confirm_password = TextEditingController();
final TextEditingController address = TextEditingController();
final _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final UserServices _userServices = UserServices();

String pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = RegExp(pattern);

SharedPreferences? preferences;
bool? loading = false;
bool? isLogedin = false;
bool obserText = true;
bool confirmobserText = true;
bool isMale = true;

class _SignUpState extends State<SignUp> {
  void signupvalidation() async {
    if (userName.text.isEmpty &&
        email.text.isEmpty &&
        password.text.isEmpty &&
        phoneNumber.text.isEmpty &&
        address.text.isEmpty) {
      _scaffoldKey.currentState
          // ignore: deprecated_member_use
          ?.showSnackBar(SnackBar(content: Text(" Flied Are Empty")));
    } else if (userName.text.length < 6) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Username Is Too Short"),
        ),
      );
    } else if (email.text.isEmpty) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Email Is Empty"),
        ),
      );
    } else if (!regExp.hasMatch(email.text)) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Please Try Vaild Email"),
        ),
      );
    } else if (password.text.isEmpty) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Password Is Empty"),
        ),
      );
    } else if (confirm_password.text.isEmpty) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Password Confirmation Is Empty"),
        ),
      );
    } else if (confirm_password.text != password.text) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Password Do Not Match"),
        ),
      );
    } else if (password.text.length < 6) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Password  Is Too Short"),
        ),
      );
    } else if (phoneNumber.text.length < 7 || phoneNumber.text.length > 7) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Phone Number Must Be 7 "),
        ),
      );
    } else if (address.text.isEmpty) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Adress Is Empty "),
        ),
      );
    } else {
      print("tudo ok");
    }
  }

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
                              controller: userName,
                              name: "Name",
                              icon: Icon(Icons.person_outline),
                            ),
                            MyTextFormField(
                              controller: email,
                              name: "Email",
                              icon: Icon(Icons.email_outlined),
                            ),
                            PasswordTextFormField(
                              controller: password,
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
                              imgPath: "images/signUp.png",
                              color: blue,
                              name: "Sign Up",
                              onPressed: () async {
                                //loginValidation();
                                if (!await user.signUp(
                                    userName.text, email.text, password.text)) {
                                  // ignore: deprecated_member_use
                                  _scaffoldKey.currentState!.showSnackBar(
                                    SnackBar(
                                      content: Text("Sign Up Failed"),
                                    ),
                                  );
                                  return;
                                }
                                pushScreenReplacement(context, HomePage());
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
                                  name: "I already have an account",
                                  onTap: () {
                                    Navigator.pop(context);
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
                                          "images/signUp.png",
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
