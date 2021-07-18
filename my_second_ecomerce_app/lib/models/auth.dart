import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Future<User?> googleSignIn();
}

class Auth implements BaseAuth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? user;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<User?> googleSignIn() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    try {
      final users = await _firebaseAuth.signInWithCredential(credential);
      user = users.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
