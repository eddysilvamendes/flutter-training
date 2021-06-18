import 'package:e_commerce_app/provider/product_provider.dart';
import 'package:e_commerce_app/screen/home.dart';
import 'package:e_commerce_app/widgets/cartsingleproduct.dart';
import 'package:e_commerce_app/widgets/notification_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

ProductProvider productProvider;

class _CheckOutState extends State<CheckOut> {
  Widget _buildBottomDetail(String startName, String endName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          startName,
          style: TextStyle(fontSize: 18),
        ),
        Text(
          endName,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = 0;
    double discount = 3;
    double discountRuppes;
    double shipping = 60;
    double total;
    productProvider = Provider.of<ProductProvider>(context);
    productProvider.getCheckOutModelList.forEach((element) {
      subtotal += element.price * element.quantity;
    });
    discountRuppes = discount / 100 * subtotal;
    total = subtotal + shipping - discountRuppes;
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        width: 100,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.only(bottom: 10),
        // ignore: deprecated_member_use
        child: RaisedButton(
          onPressed: () {},
          child: Text(
            "Buy",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          color: Color(0xff746bc9),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Check Out",
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
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 160,
              child: ListView.builder(
                itemCount: productProvider.getCheckOutModeListLength,
                itemBuilder: (context, index) {
                  return CartSingleProduct(
                    image: productProvider.getCheckOutModelList[index].image,
                    name: productProvider.getCheckOutModelList[index].name,
                    price: productProvider.getCheckOutModelList[index].price,
                    quantity:
                        productProvider.getCheckOutModelList[index].quantity,
                  );
                },
              ),
            ),
            Container(
              height: 140,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomDetail(
                      "Subtotal", "\$ ${subtotal.toStringAsFixed(2)}"),
                  _buildBottomDetail(
                      "Discount", "${discount.toStringAsFixed(2)}%"),
                  _buildBottomDetail(
                      "Shipping", "\$ ${shipping.toStringAsFixed(2)}"),
                  _buildBottomDetail("Total", "\$ ${total.toStringAsFixed(2)}"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
