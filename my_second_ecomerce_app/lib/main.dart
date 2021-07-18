import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/Admin/screen/admin_Screen.dart';
import 'package:my_second_ecomerce_app/commons/commons.dart';
import 'package:my_second_ecomerce_app/screens/login_Screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: redShade900),
      home: Login(),
    );
  }
}
