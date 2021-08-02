import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/User/widgets/commons.dart';

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
      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: grey.withOpacity(0.2),
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
