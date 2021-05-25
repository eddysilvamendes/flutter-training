import 'package:flutter/material.dart';

class GameButton {
  final id;
  String text;
  Color bg;
  bool enebled;

  GameButton(
      {this.id, this.text = "", this.bg = Colors.grey, this.enebled = true});
}
