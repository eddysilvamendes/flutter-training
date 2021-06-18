import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String myText = "";
  StreamSubscription<DocumentSnapshot> subscription;
  final DocumentReference documentReference =
      FirebaseFirestore.instance.doc("myData/dummy");

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User> _signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSa = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gSa.accessToken, idToken: gSa.idToken);

    final users = await _auth.signInWithCredential(credential);
    User user = users.user;
    print("signed in " + user.displayName);
    return user;
  }

  void _signOut() {
    googleSignIn.signOut();
    print("User Signed Out");
  }

  void _add() {
    Map<String, String> data = <String, String>{
      "name": "Eddy Mendes",
      "desc": "Flutter Training with dummy data"
    };
    documentReference.set(data).whenComplete(() {
      print("Document Added");
    }).catchError((e) => print(e));
  }

  void _delete() {
    documentReference.delete().whenComplete(() {
      print("Deleted Successfully");
      setState(() {});
    }).catchError((e) => print(e));
  }

  void _update() {
    Map<String, String> data = <String, String>{
      "name": "Lucas Davi",
      "desc": "Lovely Kid!! Updated"
    };
    documentReference.update(data).whenComplete(() {
      print("Document updated");
    });
  }

  void _fetch() {
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          myText = datasnapshot.data().toString();
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    subscription = documentReference.snapshots().listen((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          myText = datasnapshot.data().toString();
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FireBase CRUD'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: () => _signIn()
                  .then((User user) => print(user))
                  .catchError((e) => print(e)),
              child: Text("Sign in"),
              color: Colors.green,
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: _signOut,
              child: Text("Sign Out"),
              color: Colors.red,
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: _add,
              child: Text("Add"),
              color: Colors.cyan,
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: _update,
              child: Text("Update"),
              color: Colors.teal,
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: _delete,
              child: Text("Delete"),
              color: Colors.orange,
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: _fetch,
              child: Text("Fetch"),
              color: Colors.lime,
            ),
            /*Padding(padding: EdgeInsets.all(10.0)),
            // ignore: deprecated_member_use
            myText == null
                ? Container()
                : Text(myText,
                    style: TextStyle(
                      fontSize: 20,
                    ))*/
          ],
        ),
      ),
    );
  }
}
