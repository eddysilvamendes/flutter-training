import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/commons/commons.dart';
import 'package:my_second_ecomerce_app/screens/homePage.dart';
import 'package:my_second_ecomerce_app/widgets/product_Details_button.dart';
import 'package:my_second_ecomerce_app/widgets/similar_Product.dart';

class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_image;
  final product_detail_price;
  final product_detail_old_price;

  ProductDetails({
    required this.product_detail_image,
    required this.product_detail_name,
    required this.product_detail_old_price,
    required this.product_detail_price,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: red,
        title: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => HomePage(),
                ),
              );
            },
            child: Text("Freeman Shop")),
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
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart,
              color: white,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 300,
            child: GridTile(
              child: Container(
                color: white,
                child: Image.asset(widget.product_detail_image),
              ),
              footer: Container(
                color: white,
                child: ListTile(
                  leading: Text(
                    widget.product_detail_name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "\$${widget.product_detail_old_price}",
                          style: TextStyle(
                            color: grey,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "\$${widget.product_detail_price}",
                          style: TextStyle(
                            color: red,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          PickButton(),
          SubmitDetailButton(),
          Divider(),
          ListTile(
            title: Text("Product Details"),
            subtitle: Text(
                "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."),
          ),
          Divider(),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 5.0, 5.0, 5.0),
                child: Text(
                  "Product Name",
                  style: TextStyle(color: grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(widget.product_detail_name),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 5.0, 5.0, 5.0),
                child: Text(
                  "Product Brand",
                  style: TextStyle(color: grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text("Zara"),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 5.0, 5.0, 5.0),
                child: Text(
                  "Product Condition",
                  style: TextStyle(color: grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text("NEW"),
              ),
            ],
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Similar Product"),
          ),
          Container(
            height: 300,
            child: SimilarProduct(),
          ),
        ],
      ),
    );
  }
}
