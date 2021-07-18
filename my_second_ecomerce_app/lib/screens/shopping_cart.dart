import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/commons/commons.dart';
import 'package:my_second_ecomerce_app/widgets/cart_Product.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: red,
        title: Text("Cart"),
        centerTitle: true,
        elevation: 0.1,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: white,
            ),
          ),
        ],
      ),
      body: CartProduct(),
      bottomNavigationBar: Container(
        color: white,
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text("Total: "),
                subtitle: Text("\$230"),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {},
                child: Text(
                  "Check Out",
                  style: TextStyle(color: Colors.white),
                ),
                color: red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
