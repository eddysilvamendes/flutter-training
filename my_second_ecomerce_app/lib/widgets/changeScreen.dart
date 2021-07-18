import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/commons/commons.dart';

class ChangeScreen extends StatelessWidget {
  final String whichAccount;
  final Function() onTap;
  final String name;
  ChangeScreen({
    required this.name,
    required this.onTap,
    required this.whichAccount,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            whichAccount,
            style: TextStyle(
                color: white, fontWeight: FontWeight.w400, fontSize: 16),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              name,
              style: TextStyle(
                color: amber,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
