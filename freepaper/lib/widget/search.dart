// @dart=2.9
import 'package:flutter/material.dart';
import 'package:freepaper/data/data.dart';
import 'package:freepaper/model/categoryModel.dart';
import 'package:freepaper/screen/category.dart';
import 'package:freepaper/widget/alert_dialog.dart';
import 'package:freepaper/widget/custom.dart';
import 'package:freepaper/widget/searchCard.dart';

class SearchWidget extends StatefulWidget {
  final String name;
  final VoidCallback ontap;
  final TextEditingController controller;

  SearchWidget({this.name, this.ontap, this.controller});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  List<CategoryModel> search = [];

  @override
  void initState() {
    search = getCategories();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Please search for your wallpaper",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: white),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: custongrey,
                ),
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: widget.controller,
                        decoration: InputDecoration(
                          hintText: widget.name,
                          hintStyle: TextStyle(color: black),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: black),
                      ),
                    ),
                    InkWell(
                      onTap: widget.ontap,
                      child: Container(
                        child: Icon(
                          Icons.search,
                          color: black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context, builder: (cts) => BaseAlertDialog());
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trending Topics",
                        style: TextStyle(color: white),
                      ),
                      Container(
                        child: Icon(
                          Icons.arrow_forward,
                          size: 20,
                          color: white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: white,
              ),
              Row(
                children: [
                  SearchCard(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
