import 'package:e_commerce_app/model/product.dart';
import 'package:e_commerce_app/screen/home.dart';
import 'package:e_commerce_app/widgets/notification_button.dart';
import 'package:e_commerce_app/widgets/singleproduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ListProduct extends StatelessWidget {
  // Widget _buildMyGridView() {
  //   return Container(
  //     height: 600,
  //     child: StaggeredGridView.countBuilder(
  //       itemCount: snapShot.data.docs.length,
  //       scrollDirection: Axis.vertical,
  //       itemBuilder: (context, index) => SingleProduct(
  //         name: snapShot.data.docs[index]["name"],
  //         price: snapShot.data.docs[index]["price"],
  //         image: snapShot.data.docs[index]["image"],
  //       ),
  //       crossAxisCount: 2,
  //       //staggeredTileBuilder: (i) => StaggeredTile.count(1, i.isEven ? 3 : 2),
  //       staggeredTileBuilder: (index) => StaggeredTile.count(1, 2),
  //       mainAxisSpacing: 5.0,
  //       crossAxisSpacing: 5.0,
  //     ),
  //   );
  // }
  final String name;
  final List<Product> snapShot;
  ListProduct({this.name, this.snapShot});

  Widget _buildMyGridView() {
    return Container(
      height: 600,
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        scrollDirection: Axis.vertical,
        children: snapShot
            .map(
              (e) => SingleProduct(
                name: e.name,
                price: e.price,
                image: e.image,
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {},
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
            _buildMyGridView()
          ],
        ),
      ),
    );
  }
}
