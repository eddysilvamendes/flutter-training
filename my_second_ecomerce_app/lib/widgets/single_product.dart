import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/commons/commons.dart';
import 'package:my_second_ecomerce_app/screens/product_details.dart';

class SingleProduct extends StatelessWidget {
  final product_name;
  final product_picture;
  final product_old_price;
  final produt_price;

  SingleProduct(
      {this.product_name,
      this.product_old_price,
      this.product_picture,
      this.produt_price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: product_name,
        child: Material(
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ProductDetails(
                  product_detail_image: product_picture,
                  product_detail_name: product_name,
                  product_detail_old_price: product_old_price,
                  product_detail_price: produt_price,
                ),
              ),
            ),
            child: GridTile(
              footer: Container(
                height: 40.0,
                color: white,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        product_name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Text(
                      "\$$produt_price",
                      style: TextStyle(color: red, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              child: Image.asset(
                product_picture,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
