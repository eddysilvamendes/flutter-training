// @dart=2.9
import 'package:flutter/material.dart';
import 'package:freepaper/data/data.dart';
import 'package:freepaper/model/photo_model.dart';
import 'package:freepaper/widget/custom.dart';
import 'package:freepaper/widget/widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Categories extends StatefulWidget {
  final String categorieName;

  const Categories({Key key, @required this.categorieName}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<PhotosModel> photos = [];
  TextEditingController searchController = TextEditingController();
  getsearchWallpaper() async {
    String url =
        "https://api.pexels.com/v1/search?query=${widget.categorieName}&per_page=80&page=1";
    await http
        .get(Uri.parse(url), headers: {"Authorization": apiKey}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((e) {
        //print(e);
        PhotosModel photosModel = PhotosModel();
        photosModel = PhotosModel.fromMap(e);
        photos.add(photosModel);
      });
    });
    setState(() {});
  }

  @override
  void initState() {
    getsearchWallpaper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Text(widget.categorieName.toUpperCase()),
              Divider(),
              photosList(photos, context),
            ],
          ),
        ),
      ),
    );
  }
}
