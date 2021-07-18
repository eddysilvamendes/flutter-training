import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/commons/commons.dart';

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
      padding: const EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white.withOpacity(0.8),
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
