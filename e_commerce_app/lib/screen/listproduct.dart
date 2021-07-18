import 'package:e_commerce_app/model/product.dart';
import 'package:e_commerce_app/provider/category_provider.dart';
import 'package:e_commerce_app/provider/product_provider.dart';
import 'package:e_commerce_app/screen/detailscreen.dart';
import 'package:e_commerce_app/screen/search_product.dart';
import 'package:e_commerce_app/screen/searchcategory.dart';
import 'package:e_commerce_app/widgets/notification_button.dart';
import 'package:e_commerce_app/widgets/singleproduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListProduct extends StatelessWidget {
  bool isCategory = true;
  final String name;
  final List<Product> snapShot;
  ListProduct({this.name, this.snapShot, this.isCategory});

  Widget _buildMyGridView(context) {
    return Container(
      height: 600,
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        scrollDirection: Axis.vertical,
        children: snapShot
            .map(
              (e) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => DetailScreen(
                        image: e.image,
                        price: e.price,
                        name: e.name,
                      ),
                    ),
                  );
                },
                child: SingleProduct(
                  name: e.name,
                  price: e.price,
                  image: e.image,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    //final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          isCategory == true
              ? IconButton(
                  onPressed: () {
                    categoryProvider.getSearchList(list: snapShot);
                    showSearch(
                      context: context,
                      delegate: SearchCategory(),
                    );
                  },
                  icon: Icon(Icons.search),
                  color: Colors.black,
                )
              : IconButton(
                  onPressed: () {
                    productProvider.getSearchList(list: snapShot);
                    showSearch(
                      context: context,
                      delegate: SearchProduct(),
                    );
                  },
                  icon: Icon(Icons.search),
                  color: Colors.black,
                ),
          NotificationButton(),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _buildMyGridView(context)
          ],
        ),
      ),
    );
  }
}
