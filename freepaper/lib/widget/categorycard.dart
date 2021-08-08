// @dart=2.9
import 'package:flutter/material.dart';
import 'package:freepaper/data/data.dart';
import 'package:freepaper/model/categoryModel.dart';
import 'package:freepaper/screen/category.dart';
import 'package:freepaper/widget/custom.dart';

class CategoryCard extends StatefulWidget {
  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  List<CategoryModel> categories = [];

  @override
  void initState() {
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(


          itemCount: categories.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return CategoryListTile(
              imgUrl: categories[index].imgUrl,
              title: categories[index].categorieName,
            );
          },
        ),
      ),
    );
  }

  CategoryListTile({String title, String imgUrl}) {
    return InkWell(
      onTap: () {
        pushScreen(
          context,
          Categories(
            categorieName: title.toLowerCase(),
          ),
        );
      },
      child: Container(
        //margin: EdgeInsets.only(top: 0.5),
        child: Stack(
          children: [
            ClipRRect(
              child: Image.network(
                imgUrl,
                height: 150,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
              ),
              height: 150,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
