import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplace_design/app/config/themes/app_theme.dart';
import 'package:marketplace_design/app/config/routes/app_pages.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.basic,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
