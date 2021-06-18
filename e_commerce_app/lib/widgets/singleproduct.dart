import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  final String name;
  final double price;

  SingleProduct({this.image, this.name, this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 250,
        width: 165,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(vertical: 10),
              height: 190,
              width: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(image),
                ),
              ),
            ),
            Text(
              "\$ ${price.toString()}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Color(0xff9b96d6)),
            ),
            Text(
              name,
              style: TextStyle(fontSize: 17),
            )
          ],
        ),
      ),
    );
  }
}
