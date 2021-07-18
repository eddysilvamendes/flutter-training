import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/screens/product_details.dart';
import 'package:my_second_ecomerce_app/widgets/single_product.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var productList = [
    {
      "name": "Men Blazer",
      "picture": "images/products/blazer1.jpeg",
      "old_price": 169.99,
      "price": 129.99
    },
    {
      "name": "Red Dress",
      "picture": "images/products/dress1.jpeg",
      "old_price": 99.99,
      "price": 49.99
    },
    {
      "name": "Casual Pants",
      "picture": "images/products/pants1.jpg",
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
      "name": "Women Blazer",
      "picture": "images/products/blazer2.jpeg",
      "old_price": 139.99,
      "price": 109.99
    },
    {
      "name": "Hills",
      "picture": "images/products/hills1.jpeg",
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
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: SingleProduct(
            product_name: productList[index]['name'],
            product_picture: productList[index]['picture'],
            product_old_price: productList[index]['old_price'],
            produt_price: productList[index]['price'],
          ),
        );
      },
    );
  }
}
