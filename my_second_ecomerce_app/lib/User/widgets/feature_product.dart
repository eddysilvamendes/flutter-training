import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/provider/product_provider.dart';
import 'package:my_second_ecomerce_app/User/widgets/feacture_card.dart';
import 'package:provider/provider.dart';

class FeaturedProducts extends StatefulWidget {
  @override
  _FeaturedProductsState createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<UserProductProvider>(context);
    return Container(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productProvider.featured.length,
        itemBuilder: (_, index) {
          return FeaturedCard(
            product: productProvider.featured[index],
          );
        },
      ),
    );
  }
}
