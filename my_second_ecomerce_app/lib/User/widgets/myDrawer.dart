import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/Admin/screen/admin_Screen.dart';
import 'package:my_second_ecomerce_app/Admin/screen/dashboard.dart';
import 'package:my_second_ecomerce_app/provider/user_provider.dart';
import 'package:my_second_ecomerce_app/User/screens/cart.dart';
import 'package:my_second_ecomerce_app/User/screens/category.dart';
import 'package:my_second_ecomerce_app/User/screens/order.dart';
import 'package:my_second_ecomerce_app/User/widgets/category_card.dart';
import 'package:my_second_ecomerce_app/User/widgets/commons.dart';
import 'package:my_second_ecomerce_app/User/screens/shopping_cart.dart';
import 'package:my_second_ecomerce_app/User/widgets/custon_text.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final userprovider = Provider.of<UserProvider>(context);
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: CustomText(
              text: userprovider.userModel.name,
              color: white,
              weight: FontWeight.bold,
              size: 18,
            ),
            accountEmail: CustomText(
              text: userprovider.userModel.email,
              color: white,
            ),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg"),
                // child: Icon(
                //   Icons.person,
                //   color: white,
                // ),
              ),
            ),
            decoration: BoxDecoration(
              color: black,
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text("Home"),
              leading: Icon(
                Icons.home,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text("My Account"),
              leading: Icon(
                Icons.person,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await userprovider.getOrders();
              pushScreen(context, OrdersScreen());
            },
            child: ListTile(
              title: Text("My Order"),
              leading: Icon(
                Icons.bookmark_border,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => CartScreen(),
                ),
              );
            },
            child: ListTile(
              title: Text("Shopping Cart"),
              leading: Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              pushScreen(context, MyCategorie());
            },
            child: ListTile(
              title: Text("Category"),
              leading: Icon(
                Icons.category,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              pushScreenReplacement(context, Dashboard());
            },
            child: ListTile(
              title: Text("Admin"),
              leading: Icon(
                Icons.admin_panel_settings,
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text("Settings"),
              leading: Icon(
                Icons.settings,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text("About"),
              leading: Icon(
                Icons.help,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              userprovider.signOut();
            },
            child: ListTile(
              title: Text("Log Out"),
              leading: Icon(
                Icons.exit_to_app,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
