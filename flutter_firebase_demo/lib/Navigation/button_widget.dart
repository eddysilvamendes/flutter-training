import 'package:flutter/material.dart';

class ButtomWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;

  ButtomWidget({this.icon, this.text, this.onClicked});

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
        ),
        child: buildContent(),
        onPressed: onClicked,
      );

  Widget buildContent() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 28,
          ),
          SizedBox(
            width: 16,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 22, color: Colors.white),
          )
        ],
      );
}
