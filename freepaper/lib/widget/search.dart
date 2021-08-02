import 'package:flutter/material.dart';
import 'package:freepaper/widget/custom.dart';

class SearchWidget extends StatelessWidget {
  final String name;
  final VoidCallback ontap;
  final TextEditingController controller;
  SearchWidget(
      {required this.name, required this.ontap, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: custongrey,
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: name,
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: ontap,
            child: Container(
              child: Icon(Icons.search),
            ),
          ),
        ],
      ),
    );
  }
}
