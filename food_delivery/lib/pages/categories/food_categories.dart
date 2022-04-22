import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/categories_controller.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("GridView Builder"),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        child: Products(),
      ),
    );
  }
}

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    final list_item = [
      {"name": "Popular Food", "img": "assets/image/food0.png"},
      {"name": "Recommended Food", "img": "assets/image/food1.png"},
      {"name": "Drink", "img": "assets/image/food11.png"},
      {"name": "Fast Food", "img": "assets/image/food12.png"},
      {"name": "Chinese Food", "img": "assets/image/food13.png"},
      {"name": "Grelhados Food", "img": "assets/image/food14.jpeg"},
      {"name": "Prato do dia", "img": "assets/image/food15.jpeg"},
    ];
    return GetBuilder<CategoriesController>(builder: (categoriesController) {
      return categoriesController.isLoaded
          ? GridView.builder(
              itemCount: categoriesController.categoriesList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return productCart(
                    name: categoriesController.categoriesList[index].title,
                    img: list_item[index]["img"]!);
              },
            )
          : Container();
    });
  }

  Widget productCart({required String name, required String img}) {
    return Card(
      child: Hero(
          tag: name,
          child: Material(
            child: InkWell(
              onTap: () {
                print("Tapped");
              },
              child: GridTile(
                child: Image.asset(
                  img,
                  fit: BoxFit.cover,
                ),
                footer: Container(
                  color: Colors.black.withOpacity(0.2),
                  child: ListTile(
                    title: Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
