import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/commons/commons.dart';

class CartProduct extends StatefulWidget {
  const CartProduct({Key? key}) : super(key: key);

  @override
  _CartProductState createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  var product_on_the_cart = [
    {
      "name": "Men Blazer",
      "picture": "images/products/blazer1.jpeg",
      "price": 129.99,
      "size": "L",
      "quantity": 1,
      "color": "Deep Blue",
    },
    {
      "name": "Dress",
      "picture": "images/products/dress1.jpeg",
      "price": 49.99,
      "size": "M",
      "quantity": 1,
      "color": "Red",
    },
    {
      "name": "Formal Shoes",
      "picture": "images/products/shoe1.jpg",
      "old_price": 49.99,
      "price": 29.99,
      "size": "9",
      "quantity": 1,
      "color": "Grey",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: product_on_the_cart.length,
      itemBuilder: (context, index) {
        return SingleCartProduct(
          cart_product_name: product_on_the_cart[index]['name'],
          cart_product_picture: product_on_the_cart[index]['picture'],
          cart_produt_price: product_on_the_cart[index]['price'],
          cart_product_color: product_on_the_cart[index]['color'],
          cart_product_quantity: product_on_the_cart[index]['quantity'],
          cart_product_size: product_on_the_cart[index]['size'],
        );
      },
    );
  }
}

class SingleCartProduct extends StatelessWidget {
  final cart_product_name;
  final cart_product_picture;
  final cart_produt_price;
  final cart_product_size;
  final cart_product_color;
  final cart_product_quantity;

  SingleCartProduct({
    this.cart_product_color,
    this.cart_product_name,
    this.cart_product_picture,
    this.cart_product_quantity,
    this.cart_product_size,
    this.cart_produt_price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          cart_product_picture,
          width: 50.0,
          height: 60.0,
        ),
        title: Text(cart_product_name),
        subtitle: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Text("Size: "),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    cart_product_size,
                    style: TextStyle(color: red),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 8.0),
                  child: Text("Color: "),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    cart_product_color,
                    style: TextStyle(color: red),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "\$$cart_produt_price",
                style: TextStyle(
                    color: red, fontSize: 17.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
