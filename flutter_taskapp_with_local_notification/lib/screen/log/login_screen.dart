// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_taskapp_with_local_notification/screen/log/signUp_screen.dart';

import 'package:flutter_taskapp_with_local_notification/utils/theme.dart';
import 'package:flutter_taskapp_with_local_notification/widgets/social_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static String reg =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(reg);
  bool obserText = true;
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [primaryClr, Colors.cyan, Colors.cyan]),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Login",
                      style: subHeadingStyle.copyWith(
                          fontSize: 40, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "Log into your account",
                      style: headingStyle.copyWith(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  )),
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))),
                            child: TextField(
                              controller: email,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.email),
                                  hintText: "Enter your email",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))),
                            child: TextField(
                              controller: password,
                              obscureText: obserText,
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      setState(() {
                                        obserText = !obserText;
                                      });
                                    },
                                    child: Icon(
                                      obserText == true
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  hintText: "Enter your password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        loginvalidation();
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              colors: [primaryClr, Colors.cyan]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomWidgets.socialButtonCircle(
                              googleColor, FontAwesomeIcons.google,
                              iconColor: Colors.white, onTap: () {}),
                          SizedBox(width: 10),
                          CustomWidgets.socialButtonCircle(
                            facebookColor,
                            FontAwesomeIcons.facebookF,
                            iconColor: Colors.white,
                            onTap: () => print("faceBook"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => Get.to(SignUpScreen()),
                      child: Text(
                        "Dont have an Account! Sign UP",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  void loginvalidation() async {
    if (email.text.isEmpty && password.text.isEmpty) {
      Get.snackbar(
        "Error",
        "All field are empty",
        snackPosition: SnackPosition.BOTTOM,
        icon: Icon(
          Icons.error,
          color: Colors.red,
        ),
        duration: Duration(seconds: 2),
      );
    } else if (email.text.isEmpty || password.text.isEmpty) {
      Get.snackbar(
        "Error",
        "All field are required",
        snackPosition: SnackPosition.BOTTOM,
        icon: Icon(
          Icons.error,
          color: Colors.red,
        ),
        duration: Duration(seconds: 2),
      );
    } else if (!regExp.hasMatch(email.text)) {
      Get.snackbar(
        "Error",
        "Invalid Email",
        snackPosition: SnackPosition.BOTTOM,
        icon: Icon(
          Icons.error,
          color: Colors.red,
        ),
        duration: Duration(seconds: 2),
      );
    } else if (password.text.length < 8) {
      Get.snackbar(
        "Error",
        "Password must have at least 8 character",
        snackPosition: SnackPosition.BOTTOM,
        icon: Icon(
          Icons.error,
          color: Colors.red,
        ),
        duration: Duration(seconds: 2),
      );
    } else {
      //await Get.off(() => HomeScreen());
    }
  }
}
