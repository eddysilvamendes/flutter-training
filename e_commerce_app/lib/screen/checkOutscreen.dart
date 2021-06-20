import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/provider/product_provider.dart';
import 'package:e_commerce_app/screen/home.dart';
import 'package:e_commerce_app/widgets/cartsingleproduct.dart';
import 'package:e_commerce_app/widgets/notification_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

ProductProvider productProvider;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _CheckOutState extends State<CheckOut> {
  User user = FirebaseAuth.instance.currentUser;
  double subtotal = 0;
  double discount = 3;
  double discountRuppes;
  double shipping = 60;
  double total;
  int index;
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

  Widget _buildBuyButtom() {
    return Column(
      children: productProvider.userModelList.map((e) {
        // ignore: deprecated_member_use
        return RaisedButton(
          onPressed: () {
            if (productProvider.checkOutModellList.isNotEmpty) {
              FirebaseFirestore.instance.collection("Order").doc(user.uid).set({
                "Product": productProvider.checkOutModellList
                    .map((c) => {
                          "Product Name": c.name,
                          "Product Price": c.price,
                          "Product Quantity": c.quantity,
                        })
                    .toList(),
                "Product Total": total.toStringAsFixed(2),
                "User Name": e.userName,
                "User Email": e.userEmail,
                "User Number": e.userPhoneNumber,
                "User Adress": e.userAdress,
                "UserUid": user.uid,
              });
              productProvider.clearCheckOutProduct();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => HomePage(),
                ),
              );
            } else {
              // ignore: deprecated_member_use
              _scaffoldKey.currentState?.showSnackBar(
                SnackBar(
                  content: Text("Cart is Empty"),
                ),
              );
            }
          },
          child: Text(
            "Buy",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          color: Color(0xff746bc9),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);

    productProvider.getCheckOutModelList.forEach((element) {
      subtotal += element.price * element.quantity;
    });
    if (productProvider.checkOutModellList.isEmpty) {
      total = 0.0;
      discount = 0.0;
      shipping = 0.0;
    }
    discountRuppes = discount / 100 * subtotal;
    total = subtotal + shipping - discountRuppes;

    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: Container(
        height: 70,
        width: 100,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.only(bottom: 10),
        // ignore: deprecated_member_use
        child: _buildBuyButtom(),
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
                itemBuilder: (context, myIndex) {
                  index = myIndex;
                  return CartSingleProduct(
                    isCount: true,
                    index: myIndex,
                    image: productProvider.getCheckOutModelList[myIndex].image,
                    name: productProvider.getCheckOutModelList[myIndex].name,
                    price: productProvider.getCheckOutModelList[myIndex].price,
                    quantity:
                        productProvider.getCheckOutModelList[myIndex].quantity,
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
