// @dart=2.9
import 'package:flutter/material.dart';
import 'package:freepaper/data/data.dart';
import 'package:freepaper/model/categoryModel.dart';
import 'package:freepaper/screen/category.dart';
import 'package:freepaper/widget/custom.dart';

class BaseAlertDialog extends StatefulWidget {
  @override
  _BaseAlertDialogState createState() => _BaseAlertDialogState();
}

class _BaseAlertDialogState extends State<BaseAlertDialog> {
  List<CategoryModel> search = [];

  @override
  void initState() {
    search = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        "This is all your search option",
        style: TextStyle(color: white),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        //width: 200,
        child: ListView.builder(


          itemCount: search.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return searchListTile(
              imgUrl: search[index].imgUrl,
              title: search[index].categorieName,
            );
          },
        ),
      ),
      backgroundColor: kPrimaryColor,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        new FlatButton(
          child: new Text("Cancel"),
          textColor: Colors.redAccent,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  searchListTile({@required String title, @required String imgUrl}) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        pushScreen(
          context,
          Categories(
            categorieName: title.toLowerCase(),
          ),
        );
      },
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          padding: EdgeInsets.only(top: 10),
          child: Stack(
            children: [
              ClipRRect(
                child: Image.network(
                  imgUrl,
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                ),
                height: 120,
                width: MediaQuery.of(context).size.width,
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
      ),
    );
  }
}
