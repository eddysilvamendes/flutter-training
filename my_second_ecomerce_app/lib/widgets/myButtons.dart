import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/commons/commons.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String name;
  final Color color;
  final String imgPath;

  LoginButton(
      {required this.onPressed,
      required this.color,
      required this.name,
      required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        color: color,
        elevation: 0.0,
        child: MaterialButton(
            onPressed: onPressed,
            minWidth: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Image.asset(
                    imgPath,
                    width: 35.0,
                    height: 35.0,
                  ),
                ),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ],
            )),
      ),
    );
  }
}
