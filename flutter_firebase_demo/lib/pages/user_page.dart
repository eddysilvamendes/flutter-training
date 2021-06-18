import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  final String name;
  final String urlImage;

  UserPage({this.name, this.urlImage});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Image.network(
        urlImage,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
