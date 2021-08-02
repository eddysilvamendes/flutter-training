// @dart=2.9
import 'package:flutter/material.dart';
import 'package:freepaper/screen/category.dart';
import 'package:freepaper/widget/custom.dart';

class CategorieListTile extends StatelessWidget {
  final String imgUrl, title;

  const CategorieListTile(
      {Key key, @required this.imgUrl, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        margin: EdgeInsets.only(right: 4),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imgUrl,
                height: 50,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.black26,
              ),
              height: 50,
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
            )
          ],
        ),
      ),
    );
  }
}
