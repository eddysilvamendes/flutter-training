import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/commons/commons.dart';
import 'package:my_second_ecomerce_app/screens/shopping_cart.dart';
import 'package:my_second_ecomerce_app/widgets/myCarousel.dart';
import 'package:my_second_ecomerce_app/widgets/myCategories.dart';
import 'package:my_second_ecomerce_app/widgets/myDrawer.dart';
import 'package:my_second_ecomerce_app/widgets/recent_Product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: red,
        title: Text("Freeman Shop"),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => ShoppingCart(),
                ),
              );
            },
            icon: Icon(
              Icons.shopping_cart,
              color: white,
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          MyCarousel(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text("Categories"),
            ),
          ),
          MyCategories(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text("Recent Product"),
            ),
          ),
          Flexible(
            child: Products(),
          ),
        ],
      ),
    );
  }
}
