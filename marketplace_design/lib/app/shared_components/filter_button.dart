import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketplace_design/app/shared_components/custon_icon_button.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({required this.onPressed, this.size = 60, Key? key})
      : super(key: key);

  final Function() onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustonIconButton(
      icon: Icon(
        FontAwesomeIcons.slidersH,
        color: Theme.of(context).iconTheme.color,
      ),
      size: size,
      tolltip: "Filter",
      onPressed: onPressed,
    );
  }
}
