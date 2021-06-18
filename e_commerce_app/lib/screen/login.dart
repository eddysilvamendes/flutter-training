import 'package:e_commerce_app/screen/signup.dart';
import 'package:e_commerce_app/widgets/changescreen.dart';
import 'package:e_commerce_app/widgets/mybutton.dart';
import 'package:e_commerce_app/widgets/mytextformfield.dart';
import 'package:e_commerce_app/widgets/passwordtextformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
bool obserText = true;
bool isLoading = false;
final TextEditingController email = TextEditingController();
final TextEditingController userName = TextEditingController();
final TextEditingController password = TextEditingController();

class _LoginState extends State<Login> {
  void submit(context) async {
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text);
      print(result);
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
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(SnackBar(
        content: Text(error.toString()),
        duration: Duration(milliseconds: 800),
        backgroundColor: Theme.of(context).primaryColor,
      ));
    }

    setState(() {
      isLoading = false;
    });
  }

  void loginvalidation() async {
    if (email.text.isEmpty && password.text.isEmpty) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Both Flied Are Empty"),
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
    } else if (password.text.length < 8) {
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
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formkey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    MyTextFormField(
                      name: "Email",
                      controller: email,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    PasswordTextFormField(
                      obserText: obserText,
                      name: "Password",
                      controller: password,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          obserText = !obserText;
                        });
                      },
                    ),
                    MyButton(
                        name: "Login",
                        onPressed: () {
                          loginvalidation();
                        }),
                    ChangeScreen(
                        name: "SignUp",
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => SignUp(),
                            ),
                          );
                        },
                        whichAccount: "I Have Not Account!"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
