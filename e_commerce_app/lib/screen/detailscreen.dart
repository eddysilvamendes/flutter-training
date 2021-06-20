import 'package:e_commerce_app/provider/product_provider.dart';
import 'package:e_commerce_app/screen/cartscreen.dart';
import 'package:e_commerce_app/screen/home.dart';
import 'package:e_commerce_app/widgets/mybutton.dart';
import 'package:e_commerce_app/widgets/notification_button.dart';
import 'package:e_commerce_app/widgets/productcolor.dart';
import 'package:e_commerce_app/widgets/sizeproduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final double price;

  DetailScreen({this.image, this.name, this.price});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextStyle mystyle = TextStyle(fontSize: 18);
  int count = 1;

  ProductProvider productProvider;

  Widget _buildDetailImageBanner() {
    return Center(
      child: Container(
        width: 360,
        child: Card(
          child: Container(
            padding: EdgeInsets.all(13),
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.image),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameToDescription() {
    return Container(
      height: 100,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: mystyle,
              ),
              Text(
                "\$ ${widget.price.toString()}",
                style: TextStyle(fontSize: 14, color: Color(0xff9b96d6)),
              ),
              Text(
                "Description",
                style: mystyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buidDescriptionDetail() {
    return Container(
      height: 170,
      child: Wrap(
        children: [
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
            style: TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }

  Widget _buildSizePart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Size",
          style: mystyle,
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: 265,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizeProduct(size: "S"),
              SizeProduct(size: "M"),
              SizeProduct(size: "L"),
              SizeProduct(size: "XL"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColorPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          "Color",
          style: mystyle,
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: 265,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ColorProduct(color: Colors.red[200]),
              ColorProduct(color: Colors.green[200]),
              ColorProduct(color: Colors.blue[200]),
              ColorProduct(color: Colors.yellow[200]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          "Quantity",
          style: mystyle,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 40,
          width: 140,
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (count > 1) {
                      count--;
                    }
                  });
                },
                child: Icon(Icons.remove),
              ),
              Text(count.toString(), style: mystyle),
              GestureDetector(
                onTap: () {
                  setState(() {
                    count++;
                  });
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCheckOutButton() {
    return Container(
      height: 55,
      child: MyButton(
        name: "CheckOut",
        onPressed: () {
          productProvider.getCartData(
            image: widget.image,
            name: widget.name,
            price: widget.price,
            quantity: count,
          );
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => CartScreen(),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Page",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => HomePage(),
              ),
            );
          },
        ),
        actions: [
          NotificationButton(),
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            _buildDetailImageBanner(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNameToDescription(),
                  _buidDescriptionDetail(),
                  _buildSizePart(),
                  _buildColorPart(),
                  _buildQuantityPart(),
                  SizedBox(
                    height: 15,
                  ),
                  _buildCheckOutButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
