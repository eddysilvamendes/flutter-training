// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_taskapp_with_local_notification/api/google_sign_in_api.dart';
import 'package:flutter_taskapp_with_local_notification/screen/home_screen.dart';
import 'package:flutter_taskapp_with_local_notification/screen/theme.dart';
import 'package:flutter_taskapp_with_local_notification/widgets/social_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static String reg =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(reg);
  bool obserText = true;
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();

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
                      "Sign UP",
                      style: subHeadingStyle.copyWith(
                          fontSize: 40, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "Create an account to continue!",
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
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
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
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              child: TextField(
                                controller: confirmpassword,
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
                                    hintText: "Confirm your password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey),
                                ),
                              ),
                              child: TextField(
                                controller: phoneNumber,
                                decoration: InputDecoration(
                                    hintText: "Telefone",
                                    suffixIcon: Icon(Icons.phone),
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
                      GestureDetector(
                        onTap: () {
                          signupvalidation();
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
                              "SignUp",
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
                              googleColor,
                              FontAwesomeIcons.google,
                              iconColor: Colors.white,
                              onTap: () {}, // signIn,
                            ),
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
                        onTap: () => Get.back(),
                        child: Text(
                          "Already have an account! Login",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  void signupvalidation() async {
    if (email.text.isEmpty &&
        password.text.isEmpty &&
        phoneNumber.text.isEmpty &&
        confirmpassword.text.isEmpty) {
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
    } else if (email.text.isEmpty ||
        password.text.isEmpty ||
        phoneNumber.text.isEmpty ||
        confirmpassword.text.isEmpty) {
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
    } else if (password.text != confirmpassword.text) {
      Get.snackbar(
        "Error",
        "Password does not mach",
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
    } else if (phoneNumber.text.length < 7 || phoneNumber.text.length > 7) {
      Get.snackbar(
        "Error",
        "Invalid Phone Number",
        snackPosition: SnackPosition.BOTTOM,
        icon: Icon(
          Icons.error,
          color: Colors.red,
        ),
        duration: Duration(seconds: 2),
      );
    } else {
      //signUpsubmit();
      Get.back();
      Get.snackbar(
        "Sign UP",
        "Account Created Sucessfuly",
        snackPosition: SnackPosition.BOTTOM,
        icon: Icon(
          Icons.done,
          color: Colors.black,
        ),
        duration: Duration(seconds: 2),
      );
    }
  }

  /*Future signIn() async {
    final user = await GoogleSignInApi.login();
    if (user == null) {
      Get.snackbar("Error", "Sign in Failed");
    } else {
      Get.off(
        HomeScreen(user: user),
      );
    }
  }*/
}
