import 'package:e_commerce_app/provider/product_provider.dart';
import 'package:e_commerce_app/screen/checkOutscreen.dart';
import 'package:e_commerce_app/screen/detailscreen.dart';
import 'package:e_commerce_app/screen/home.dart';
import 'package:e_commerce_app/widgets/cartsingleproduct.dart';
import 'package:e_commerce_app/widgets/notification_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

ProductProvider productProvider;

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    print("entere CArd Screen");

    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        width: 100,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.only(bottom: 10),
        // ignore: deprecated_member_use
        child: RaisedButton(
          onPressed: () {
            productProvider.addNotification("Notification");
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => CheckOut()));
          },
          child: Text(
            "Continuos",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          color: Color(0xff746bc9),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Cart",
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
      body: ListView.builder(
        itemCount: productProvider.getCartModelLength,
        itemBuilder: (context, index) => CartSingleProduct(
          isCount: false,
          image: productProvider.getCartModelList[index].image,
          name: productProvider.getCartModelList[index].name,
          price: productProvider.getCartModelList[index].price,
          quantity: productProvider.getCartModelList[index].quantity,
        ),
      ),
    );
  }
}
