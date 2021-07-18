import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class MyCarousel extends StatefulWidget {
  const MyCarousel({Key? key}) : super(key: key);

  @override
  _MyCarouselState createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210.0,
      width: double.infinity,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage("images/c1.jpg"),
          AssetImage("images/m1.jpeg"),
          AssetImage("images/m2.jpg"),
          AssetImage("images/w1.jpeg"),
          AssetImage("images/w3.jpeg"),
          AssetImage("images/w4.jpeg"),
        ],
        autoplay: true,
        showIndicator: false,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 2000),
        autoplayDuration: Duration(seconds: 5),
      ),
    );
  }
}
