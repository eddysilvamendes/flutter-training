import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_second_ecomerce_app/Admin/models/db_manage.dart';

class AlertFormOption extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controllerKey;
  final String name;
  final String message;
  final String dbName;

  AlertFormOption(
      {required this.controllerKey,
      required this.formKey,
      required this.message,
      required this.name,
      required this.dbName});

  @override
  Widget build(BuildContext context) {
    DBService _dbservice = DBService();
    return AlertDialog(
      content: Form(
        key: formKey,
        child: TextFormField(
          controller: controllerKey,
          decoration: InputDecoration(hintText: name),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              if (controllerKey.text.isNotEmpty) {
                _dbservice.createDB(controllerKey.text, dbName);
                Fluttertoast.showToast(msg: message);
                Navigator.pop(context);
              } else {
                Fluttertoast.showToast(msg: "Empty Field");
                return null;
              }
            },
            child: Text('ADD')),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('CANCEL')),
      ],
    );
  }
}
