import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String name;
  MyButton({this.name, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      // ignore: deprecated_member_use
      child: RaisedButton(
        child: Text(
          name,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        color: Color(0xff746bc9),
        onPressed: onPressed,
      ),
    );
  }
}
