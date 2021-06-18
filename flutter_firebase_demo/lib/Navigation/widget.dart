import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/Crud/crudSample.dart';
import 'package:flutter_firebase_demo/Wallpaper/wall_screen.dart';
import 'package:flutter_firebase_demo/pages/people_screen.dart';

final padding = EdgeInsets.symmetric(horizontal: 20);
Widget buildHeader(
        {String urlImage, String name, String email, VoidCallback onClicked}) =>
    InkWell(
      onTap: onClicked,
      child: Container(
        padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(urlImage),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(width: 4),
                Text(
                  email,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
            Spacer(),
            CircleAvatar(
              radius: 24,
              backgroundColor: Color.fromRGBO(30, 30, 168, 1),
              child: Icon(
                Icons.add_comment_outlined,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );

Widget buildMenuItem({
  String text,
  IconData icon,
  VoidCallback onClicked,
}) {
  final color = Colors.white;
  final hoverColor = Colors.white70;
  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(
      text,
      style: TextStyle(color: color),
    ),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}

void selectedItem(BuildContext context, int index) {
  Navigator.of(context).pop();
  switch (index) {
    case 0:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => PeoplePage()));
      break;
    case 2:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
      break;
    case 3:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => WallScreen()));
      break;
  }
}
