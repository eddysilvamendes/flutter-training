import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/Admin/screen/admin_Screen.dart';
import 'package:my_second_ecomerce_app/commons/commons.dart';
import 'package:my_second_ecomerce_app/screens/shopping_cart.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Edilson Mendes"),
            accountEmail: Text("eddysilvamendes19@gmail.com"),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundColor: grey,
                child: Icon(
                  Icons.person,
                  color: white,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: pink,
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text("Home"),
              leading: Icon(
                Icons.home,
                color: red,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text("My Account"),
              leading: Icon(
                Icons.person,
                color: red,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text("Order"),
              leading: Icon(
                Icons.shopping_basket,
                color: red,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => ShoppingCart(),
                ),
              );
            },
            child: ListTile(
              title: Text("Shopping Cart"),
              leading: Icon(
                Icons.shopping_cart,
                color: red,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text("Favorities"),
              leading: Icon(
                Icons.favorite,
                color: red,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) => Admin(),
                ),
              );
            },
            child: ListTile(
              title: Text("Admin"),
              leading: Icon(
                Icons.admin_panel_settings,
                color: Colors.red,
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
                color: blue,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: ListTile(
              title: Text("Log Out"),
              leading: Icon(
                Icons.exit_to_app,
                color: red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
