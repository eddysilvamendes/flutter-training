import 'package:cvnews/widget/custom.dart';
import 'package:flutter/material.dart';

Widget search( String name,
 VoidCallback ontap,
 TextEditingController controller){
  return Container(
    decoration: BoxDecoration(
      color: custongrey,
      borderRadius: BorderRadius.circular(30),
    ),
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.symmetric(horizontal: 25),
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