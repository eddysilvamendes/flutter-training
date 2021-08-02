import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/User/widgets/commons.dart';

class ChangeScreen extends StatelessWidget {
  final Function() onTap;
  final String name;
  ChangeScreen({
    required this.name,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onTap,
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
        ));
  }
}
