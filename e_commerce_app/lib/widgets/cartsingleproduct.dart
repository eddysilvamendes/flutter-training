import 'package:e_commerce_app/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartSingleProduct extends StatefulWidget {
  final String name;
  final String image;
  final double price;
  int quantity;
  bool isCount;
  final int index;

  CartSingleProduct(
      {this.image,
      this.name,
      this.price,
      this.quantity,
      this.isCount,
      this.index});

  @override
  _CartSingleProductState createState() => _CartSingleProductState();
}

TextStyle mystyle = TextStyle(fontSize: 18);

class _CartSingleProductState extends State<CartSingleProduct> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);

    return Container(
      height: 150,
      width: double.infinity,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 110,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.image),
                    ),
                  ),
                ),
                Container(
                  height: 140,
                  width: widget.isCount == true ? 250 : 270,
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.name),
                              IconButton(
                                onPressed: () {
                                  widget.isCount == false
                                      ? productProvider
                                          .deleteCartProduct(widget.index)
                                      : productProvider
                                          .deleteCheckOutProduct(widget.index);
                                },
                                icon: Icon(Icons.close),
                              )
                            ],
                          ),
                        ),
                        Text("Cloths"),
                        Text(
                          "\$ ${widget.price}",
                          style: TextStyle(
                              color: Color(0xff9b96d6),
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 35,
                          width: widget.isCount == false ? 120 : 100,
                          child: widget.isCount == false
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (widget.quantity > 1) {
                                            widget.quantity--;
                                            productProvider.getCheckOutData(
                                                quantity: widget.quantity,
                                                image: widget.image,
                                                name: widget.name,
                                                price: widget.price);
                                          }
                                        });
                                      },
                                      child: Icon(Icons.remove),
                                    ),
                                    Text(
                                      widget.quantity.toString(),
                                      style: mystyle,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          widget.quantity++;
                                          productProvider.getCheckOutData(
                                              quantity: widget.quantity,
                                              image: widget.image,
                                              name: widget.name,
                                              price: widget.price);
                                        });
                                      },
                                      child: Icon(Icons.add),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Quantity : "),
                                    Text(
                                      widget.quantity.toString(),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
