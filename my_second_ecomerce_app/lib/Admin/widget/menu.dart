import 'package:flutter/material.dart';

class MyMenu extends StatelessWidget {
  final Icon icon;
  final String name;
  final VoidCallback onPressed;

  MyMenu({required this.name, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(name),
      onTap: onPressed,
    );
  }
}
