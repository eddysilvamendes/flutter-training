import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_second_ecomerce_app/commons/commons.dart';
import 'package:my_second_ecomerce_app/screens/homePage.dart';
import 'package:my_second_ecomerce_app/screens/signUp.dart';
import 'package:my_second_ecomerce_app/widgets/changeScreen.dart';
import 'package:my_second_ecomerce_app/widgets/myButtons.dart';
import 'package:my_second_ecomerce_app/widgets/myTextFormField.dart';
import 'package:my_second_ecomerce_app/widgets/passwordTextFormField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

String pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = RegExp(pattern);

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  SharedPreferences? preferences;
  bool? loading = false;
  bool? isLogedin = false;
  bool obserText = true;

  @override
  void initState() {
    super.initState();

    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });

    preferences = await SharedPreferences.getInstance();
    isLogedin = await googleSignIn.isSignedIn();

    if (isLogedin == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) => HomePage(),
        ),
      );
    }
    setState(() {
      loading = false;
    });
  }

  Future _signInWithGoogle() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });

    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);
    final users = await firebaseAuth.signInWithCredential(credential);
    try {
      User? user = users.user;
      FirebaseFirestore.instance.collection("googleUsers").doc(user!.uid).set({
        "id": user.uid,
        "UserName": user.displayName,
        "ProfilePicture": user.photoURL
      });
      await preferences!.setString("id", user.uid);
      await preferences?.setString("UserName", user.displayName!);
      await preferences!.setString("ProfilePicture", user.photoURL!);
      Fluttertoast.showToast(msg: "Logged In");

      setState(() {
        loading = false;
        isLogedin = true;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) => HomePage(),
        ),
      );
      //return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void submit(context) async {
    try {
      setState(() {
        loading = true;
      });
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text);

      print(result);
      await preferences!.setString("UserId", result.user!.uid);
      await preferences?.setString("Email", result.user!.email!);
      Fluttertoast.showToast(msg: "Logged In");
      setState(() {
        loading = false;
        isLogedin = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) => HomePage(),
          ),
        );
      });
    } on PlatformException catch (error) {
      var message = "Please Check Your Internet Connection ";
      if (error.message != null) {
        message = error.message.toString();
      }
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(message.toString()),
          duration: Duration(milliseconds: 1000),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      setState(() {
        loading = false;
      });
    } catch (error) {
      setState(() {
        loading = false;
      });
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
        content: Text(error.toString()),
        duration: Duration(milliseconds: 800),
        backgroundColor: Theme.of(context).primaryColor,
      ));
    }

    setState(() {
      loading = false;
    });
  }

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
      submit(context);
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
                width: 120.0,
                height: 120.0,
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
                      onPressed: () {
                        loginValidation();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Forgot Password",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: white,
                        ),
                      ),
                    ),
                    ChangeScreen(
                        name: "SignUp",
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => SignUp(),
                            ),
                          );
                        },
                        whichAccount: "Don't Have an Account? Click Here"),
                    Divider(
                      color: white,
                    ),
                    Text(
                      "Other way to login",
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
                      onPressed: () {
                        _signInWithGoogle();
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
