// @dart=2.9
import 'package:flutter/material.dart';
import 'package:freepaper/data/data.dart';
import 'package:freepaper/model/categoryModel.dart';
import 'package:freepaper/screen/category.dart';
import 'package:freepaper/widget/custom.dart';

class SearchCard extends StatefulWidget {
  const SearchCard({Key key}) : super(key: key);

  @override
  _SearchCardState createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  List<CategoryModel> search = [];


  @override
  void initState() {
    search = getCategories();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: Container(
          height: 110,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(

            padding: EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            itemCount: 6,

            shrinkWrap: true,
            itemBuilder: (context, index) {
              return searchListTile(
                imgUrl: search[index].imgUrl,
                title: search[index].categorieName,
              );
            },

        ),
      ),
    );
  }

  searchListTile({ String title,  String imgUrl}){
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
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: Stack(
          children: [
            ClipRRect(
              child: Image.network(
                imgUrl,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
              ),
              height: 100,
              width: 100,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
