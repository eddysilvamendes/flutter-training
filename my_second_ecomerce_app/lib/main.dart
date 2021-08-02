import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/Admin/provider/app_states.dart';
import 'package:my_second_ecomerce_app/Admin/provider/product_provider.dart';
import 'package:my_second_ecomerce_app/User/screens/homePage.dart';
import 'package:my_second_ecomerce_app/User/screens/login_Screen.dart';
import 'package:my_second_ecomerce_app/User/widgets/splashScreen.dart';

import 'package:my_second_ecomerce_app/provider/app.dart';
import 'package:my_second_ecomerce_app/provider/category_provider.dart';
import 'package:my_second_ecomerce_app/provider/order_provider.dart';
import 'package:my_second_ecomerce_app/provider/product_provider.dart';
import 'package:my_second_ecomerce_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider.initialize(),
        ),
        ChangeNotifierProvider<AppState>(
          create: (context) => AppState(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<UserProductProvider>(
          create: (context) => UserProductProvider.initialize(),
        ),
        ChangeNotifierProvider<AppProvider>(
          create: (context) => AppProvider(),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider.initialize(),
        ),
        ChangeNotifierProvider<OrderProvider>(
          create: (context) => OrderProvider.initialize(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.deepOrange),
        home: ScreenController(),
      ),
    );
  }
}

class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch (user.status) {
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticaded:
      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
        return HomePage();
      default:
        return Login();
    }
  }
}
