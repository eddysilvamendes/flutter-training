import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/widgets/single_product.dart';

class SimilarProduct extends StatefulWidget {
  const SimilarProduct({Key? key}) : super(key: key);

  @override
  _SimilarProductState createState() => _SimilarProductState();
}

class _SimilarProductState extends State<SimilarProduct> {
  var productList = [
    {
      "name": "Red Dress",
      "picture": "images/products/dress2.jpeg",
      "old_price": 99.99,
      "price": 49.99
    },
    {
      "name": "Casual Pants",
      "picture": "images/products/pants2.jpeg",
      "old_price": 29.99,
      "price": 12.99
    },
    {
      "name": "Formal Shoes",
      "picture": "images/products/shoe1.jpg",
      "old_price": 49.99,
      "price": 29.99
    },
    {
      "name": "Hills",
      "picture": "images/products/hills2.jpeg",
      "old_price": 29.99,
      "price": 9.99
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: productList.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return SingleProduct(
          product_name: productList[index]['name'],
          product_picture: productList[index]['picture'],
          product_old_price: productList[index]['old_price'],
          produt_price: productList[index]['price'],
        );
      },
    );
  }
}
