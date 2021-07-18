import 'package:e_commerce_app/model/product.dart';
import 'package:e_commerce_app/provider/category_provider.dart';
import 'package:e_commerce_app/provider/product_provider.dart';
import 'package:e_commerce_app/widgets/singleproduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchProduct extends SearchDelegate<void> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    ProductProvider productprovider = Provider.of<ProductProvider>(context);
    List<Product> searchProduct = productprovider.searchProductList(query);
    return GridView.count(
      childAspectRatio: 0.7,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: searchProduct
          .map(
            (e) => SingleProduct(
              image: e.image,
              name: e.name,
              price: e.price,
            ),
          )
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ProductProvider productprovider = Provider.of<ProductProvider>(context);
    List<Product> searchProduct = productprovider.searchProductList(query);
    return GridView.count(
      childAspectRatio: 0.6,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: searchProduct
          .map(
            (e) => SingleProduct(
              image: e.image,
              name: e.name,
              price: e.price,
            ),
          )
          .toList(),
    );
  }
}
