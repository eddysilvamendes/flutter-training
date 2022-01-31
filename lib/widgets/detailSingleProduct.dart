import 'package:flutter/material.dart';

class DetailSingleProduct extends StatelessWidget {
  final String image;
  final String name;
  final double price;

  DetailSingleProduct({this.image, this.name, this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        //height: 200,
        // width: 150,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              height: 190,
              width: 280,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(image),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xff9b96d6)),
            ),
            Text(
              "\$ ${price.toString()}",
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
