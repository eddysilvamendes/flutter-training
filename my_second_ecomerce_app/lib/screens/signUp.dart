import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_second_ecomerce_app/commons/commons.dart';
import 'package:my_second_ecomerce_app/models/auth.dart';
import 'package:my_second_ecomerce_app/models/user.dart';
import 'package:my_second_ecomerce_app/screens/homePage.dart';
import 'package:my_second_ecomerce_app/screens/login_Screen.dart';
import 'package:my_second_ecomerce_app/widgets/changeScreen.dart';
import 'package:my_second_ecomerce_app/widgets/myButtons.dart';
import 'package:my_second_ecomerce_app/widgets/myTextFormField.dart';
import 'package:my_second_ecomerce_app/widgets/passwordTextFormField.dart';
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
  Auth auth = Auth();

  late final UserCredential createUser;
  void signUpsubmit() async {
    print("SignUp Submited");
    // ignore: unused_local_variable
    final FormState? _form = _formKey.currentState;
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);
      FirebaseFirestore.instance.collection("User").doc(result.user!.uid).set({
        "UserName": userName.text,
        "UserId": result.user!.uid,
        "Email": email.text,
        "UserGender": isMale == true ? "Male" : "Female",
        "Phone": phoneNumber.text,
        "Adress": address.text,
      });

      setState(() {
        loading = false;
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) => Login()));
      });
    } on PlatformException catch (error) {
      var message = "Please Check Your Internet Connection ";
      if (error.message != null) {
        message = error.message.toString();
      }
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
        content: Text(message.toString()),
        duration: Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));
    }
  }

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
      signUpsubmit();
      //_signUp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Image.asset(
            "images/back.jpg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Image.asset(
                "images/logo3.png",
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
          Container(
            color: black.withOpacity(0.5),
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            alignment: Alignment.center,
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyTextFormField(
                      controller: userName,
                      name: "Username",
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
                    PasswordTextFormField(
                      controller: confirm_password,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          confirmobserText = !confirmobserText;
                        });
                      },
                      name: "Confirm Password",
                      obserText: confirmobserText,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isMale = !isMale;
                        });
                      },
                      child: Container(
                        height: 68,
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: white.withOpacity(0.8),
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Row(
                              children: [
                                Icon(Icons.login_outlined),
                                Padding(padding: EdgeInsets.only(left: 18.0)),
                                Text(
                                  isMale == true ? "Male" : "Female",
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // MyTextFormField(
                    //   name: "Phone Number",
                    //   controller: phoneNumber,
                    //   icon: Icon(Icons.phone),
                    // ),
                    // MyTextFormField(
                    //   icon: Icon(Icons.house),
                    //   name: "Adress",
                    //   controller: address,
                    // ),
                    LoginButton(
                      imgPath: "images/signUp.png",
                      color: blue,
                      name: "Sign Up",
                      onPressed: () {
                        signupvalidation();
                      },
                    ),
                    Divider(
                      color: white,
                    ),
                    Text(
                      "Other way to Sign Up",
                      style: TextStyle(
                        color: amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    LoginButton(
                      imgPath: "images/googleLogo.png",
                      color: red,
                      name: "Google",
                      onPressed: () async {
                        User? user = await auth.googleSignIn();
                        if (user == null) {
                          _userServices.createUser({
                            "name": user!.displayName,
                            "email": user.email,
                            "userId": user.uid
                          });
                        }
                      },
                    ),
                    LoginButton(
                      imgPath: "images/logoFb.png",
                      color: grey,
                      name: "Facebook",
                      onPressed: () {
                        // _signInWithGoogle();
                      },
                    ),
                    ChangeScreen(
                        name: "Sign In",
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => Login(),
                            ),
                          );
                        },
                        whichAccount: "Already Have an Account? Click Here"),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: loading ?? true,
            child: Center(
              child: Container(
                color: white.withOpacity(0.7),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(red),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
