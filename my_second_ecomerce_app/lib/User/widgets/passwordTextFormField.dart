import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/User/widgets/commons.dart';

class PasswordTextFormField extends StatelessWidget {
  final bool obserText;
  final TextEditingController controller;
  final String name;

  final VoidCallback onTap;
  PasswordTextFormField({
    required this.controller,
    required this.onTap,
    required this.name,
    required this.obserText,
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
            obscureText: obserText,
            decoration: InputDecoration(
              hintText: name,
              icon: Icon(Icons.lock_outline),
              border: InputBorder.none,
              suffixIcon: GestureDetector(
                onTap: onTap,
                child: Icon(
                  obserText == true ? Icons.visibility : Icons.visibility_off,
                  color: black,
                ),
              ),
              hintStyle: TextStyle(color: black),
            ),
          ),
        ),
      ),
    );
  }
}
