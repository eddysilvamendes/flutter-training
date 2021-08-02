import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/User/widgets/commons.dart';

class MenuButton extends StatelessWidget {
  final String name;
  final String subName;
  final Icon icon;

  MenuButton({required this.icon, required this.name, required this.subName});
  MaterialColor active = materialRed;
  MaterialColor notActive = materialGrey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: () {},
        child: Card(
          child: ListTile(
              title: FlatButton.icon(
                onPressed: null,
                icon: icon,
                label: Text(name),
              ),
              subtitle: Text(
                subName,
                textAlign: TextAlign.center,
                style: TextStyle(color: active, fontSize: 60.0),
              )),
        ),
      ),
    );
  }
}
