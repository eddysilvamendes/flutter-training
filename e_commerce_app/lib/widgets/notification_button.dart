import 'package:e_commerce_app/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';

class NotificationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Badge(
      position: BadgePosition(
        end: 5,
        top: 8,
      ),
      badgeColor: Colors.red,
      badgeContent: Text(
        productProvider.getNotificationIndex.toString(),
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      child: IconButton(
        icon: Icon(
          Icons.notifications_none,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
    );
  }
}
