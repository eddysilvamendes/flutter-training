import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final Icon icon;

  MyTextFormField({
    required this.controller,
    required this.name,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white.withOpacity(0.8),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
                hintText: name, icon: icon, border: InputBorder.none),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
      ),
    );
  }
}
