// @dart=2.9
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freepaper/model/photo_model.dart';
import 'package:freepaper/screen/full_scree.dart';
import 'package:freepaper/widget/custom.dart';

Widget photosList(List<PhotosModel> photos, context) {
  return Container(
    child: GridView.count(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        padding: EdgeInsets.symmetric(horizontal: 16),
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: photos.map((e) {
          return GridTile(
            child: InkWell(
              onTap: () {
                pushScreen(
                  context,
                  FullScreen(imgUrl: e.src.portrait),
                );
              },
              child: Hero(
                tag: e.src.portrait,
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: kIsWeb
                        ? Image.network(
                      e.src.portrait,
                      height: 50,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                        : CachedNetworkImage(
                        imageUrl: e.src.portrait,
                        placeholder: (context, url) => Container(
                          color: Color(0xfff5f8fd),
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          );
        }).toList()),
  );
}

Widget myButton(BuildContext context, String name, VoidCallback ontap){
  return Padding(
    padding: const EdgeInsets.all(4.0),

    child: Material(
      borderRadius: BorderRadius.circular(30.0),
      color:Color(0xff1C1B1B).withOpacity(0.6),
      elevation: 0.0,
      child: MaterialButton(onPressed: ontap,
        minWidth: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(name, style: TextStyle(
            color: white,
            fontWeight: FontWeight.w500,
            fontSize: 16.0),),

          ],
        ),
      ),
    ),
  );
}
