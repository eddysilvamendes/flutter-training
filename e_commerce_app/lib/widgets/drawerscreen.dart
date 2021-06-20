import 'package:e_commerce_app/screen/profilescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyDrawer extends StatefulWidget {
  String userName;
  String userEmail;
  String userImage;

  MyDrawer(
      {@required this.userName,
      @required this.userEmail,
      @required this.userImage});
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool homeColor = true;

  bool cartColor = false;

  bool aboutColor = false;

  bool contactColor = false;

  bool profileColor = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              widget.userName,
              style: TextStyle(color: Colors.black),
            ),
            currentAccountPicture: CircleAvatar(
              maxRadius: 45,
              backgroundImage: widget.userImage == null
                  ? NetworkImage(
                      "https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg")
                  : NetworkImage(widget.userImage),
            ),
            decoration: BoxDecoration(
              color: Color(0xfff2f2f2),
            ),
            accountEmail: Text(
              widget.userEmail,
              style: TextStyle(color: Colors.black),
            ),
          ),
          ListTile(
            selected: homeColor,
            onTap: () {
              setState(() {
                homeColor = true;
                contactColor = false;
                cartColor = false;
                aboutColor = false;
                profileColor = false;
              });
            },
            leading: Icon(Icons.home),
            title: Text("Home"),
          ),
          ListTile(
            selected: cartColor,
            onTap: () {
              setState(() {
                cartColor = true;
                contactColor = false;
                homeColor = false;
                aboutColor = false;
                profileColor = false;
              });
            },
            leading: Icon(Icons.shopping_cart),
            title: Text("Cart"),
          ),
          ListTile(
            selected: aboutColor,
            onTap: () {
              setState(() {
                aboutColor = true;
                contactColor = false;
                cartColor = false;
                homeColor = false;
                profileColor = false;
              });
            },
            leading: Icon(Icons.info),
            title: Text("About"),
          ),
          ListTile(
            selected: contactColor,
            onTap: () {
              setState(() {
                contactColor = true;
                homeColor = false;
                cartColor = false;
                aboutColor = false;
                profileColor = false;
              });
            },
            leading: Icon(Icons.phone),
            title: Text("Contact Us"),
          ),
          ListTile(
            selected: profileColor,
            onTap: () {
              setState(() {
                contactColor = false;
                homeColor = false;
                cartColor = false;
                aboutColor = false;
                profileColor = true;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => ProfileScreen(),
                ),
              );
            },
            leading: Icon(Icons.verified_user),
            title: Text("Profile"),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("LogOut"),
          ),
        ],
      ),
    );
  }
}
