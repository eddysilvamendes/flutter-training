import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/screen/home.dart';
import 'package:e_commerce_app/screen/login.dart';
import 'package:e_commerce_app/widgets/changescreen.dart';
import 'package:e_commerce_app/widgets/mybutton.dart';
import 'package:e_commerce_app/widgets/mytextformfield.dart';
import 'package:e_commerce_app/widgets/passwordtextformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
bool oserText = true;
bool isMale = true;
final TextEditingController email = TextEditingController();
final TextEditingController userName = TextEditingController();
final TextEditingController phoneNumber = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController address = TextEditingController();

class _SignUpState extends State<SignUp> {
  void signUpsubmit() async {
    print("SignUp Submited");
    final FormState _form = _formkey.currentState;
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);
      FirebaseFirestore.instance.collection("User").doc(result.user.uid).set({
        "UserName": userName.text,
        "UserId": result.user.uid,
        "Email": email.text,
        "UserGender": isMale == true ? "Male" : "Female",
        "Phone": phoneNumber.text,
        "Adress": address.text,
      });
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => HomePage()));
      setState(() {
        isLoading = false;
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
    } else if (password.text.length < 8) {
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
    }
  }

  Widget _buildAllTextFormField() {
    return Form(
      key: _formkey,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MyTextFormField(
              name: "UserName",
              controller: userName,
            ),
            SizedBox(
              height: 10,
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
              controller: password,
              name: "Password",
              onTap: () {
                FocusScope.of(context).unfocus();
                setState(() {
                  obserText = !obserText;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isMale = !isMale;
                });
              },
              child: Container(
                height: 60,
                padding: EdgeInsets.only(left: 10),
                width: double.infinity,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Center(
                  child: Row(
                    children: [
                      Text(
                        isMale == true ? "Male" : "Female",
                        style: TextStyle(color: Colors.black87, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MyTextFormField(
              name: "Phone Number",
              controller: phoneNumber,
            ),
            SizedBox(
              height: 10,
            ),
            MyTextFormField(
              name: "Address",
              controller: address,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPart() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildAllTextFormField(),
          SizedBox(
            height: 10,
          ),
          MyButton(
            name: "SignUp",
            onPressed: () {
              signupvalidation();
            },
          ),
          ChangeScreen(
            name: "Login",
            whichAccount: "I Have Already An Account!",
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => Login(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: [
          Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 500,
            child: _buildBottomPart(),
          ),
        ],
      ),
    );
  }
}
