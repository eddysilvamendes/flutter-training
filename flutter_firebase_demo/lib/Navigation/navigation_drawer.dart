import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/pages/user_page.dart';
import 'package:flutter_firebase_demo/Navigation/widget.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final name = 'Zed';
    final email = 'zed@ninja.udead';
    final urlImage =
        'https://mobaflow.games/static/26b828f44c8a5b8249b05507e0dd2081/ac53a/Zedthumbnail.jpg';
    return Drawer(
      child: Material(
        color: Color.fromRGBO(50, 75, 205, 1),
        child: ListView(
          children: [
            buildHeader(
                urlImage: urlImage,
                name: name,
                email: email,
                onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserPage(
                          name: name,
                          urlImage: urlImage,
                        )))),
            Container(
              padding: padding,
              child: Column(
                children: [
                  SizedBox(
                    height: 48,
                  ),
                  buildMenuItem(
                    text: 'People',
                    icon: Icons.people,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  buildMenuItem(
                    text: 'FireBase Crud',
                    icon: Icons.add,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  buildMenuItem(
                    text: 'WallPaper',
                    icon: Icons.wallpaper,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  SizedBox(height: 24),
                  Divider(color: Colors.white70),
                  SizedBox(height: 24),
                  SizedBox(
                    height: 20,
                  ),
                  buildMenuItem(
                    text: 'Plugins',
                    icon: Icons.account_tree_outlined,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  buildMenuItem(
                      text: 'Notifications',
                      icon: Icons.notifications_outlined),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
