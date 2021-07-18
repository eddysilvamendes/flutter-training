import 'package:flutter/material.dart';

class MyCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CategoriesItem(
            image_caption: "Tshirt",
            image_location: "images/cats/tshirt.png",
          ),
          CategoriesItem(
            image_caption: "Dress",
            image_location: "images/cats/dress.png",
          ),
          CategoriesItem(
            image_caption: "Formal",
            image_location: "images/cats/formal.png",
          ),
          CategoriesItem(
            image_caption: "Shoes",
            image_location: "images/cats/shoe.png",
          ),
          CategoriesItem(
            image_caption: "Jeans",
            image_location: "images/cats/jeans.png",
          ),
          CategoriesItem(
            image_caption: "Informal",
            image_location: "images/cats/informal.png",
          ),
          CategoriesItem(
            image_caption: "Accessories",
            image_location: "images/cats/accessories.png",
          ),
        ],
      ),
    );
  }
}

class CategoriesItem extends StatelessWidget {
  final String image_location;
  final String image_caption;

  CategoriesItem({required this.image_caption, required this.image_location});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 85,
          child: ListTile(
              title: Image.asset(
                image_location,
                width: 40.0,
                height: 40.0,
              ),
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  image_caption,
                  style: TextStyle(fontSize: 14),
                ),
              )),
        ),
      ),
    );
  }
}
