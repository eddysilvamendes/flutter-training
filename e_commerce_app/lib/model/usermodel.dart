import 'package:flutter/material.dart';

class UserModel {
  String userName;
  String userEmail;
  String userGender;
  String userPhoneNumber;
  String userAdress;

  UserModel({
    @required this.userEmail,
    @required this.userGender,
    @required this.userName,
    @required this.userPhoneNumber,
    @required this.userAdress,
  });
}
