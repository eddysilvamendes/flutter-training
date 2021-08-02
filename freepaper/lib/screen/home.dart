// @dart=2.9
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freepaper/data/data.dart';
import 'package:freepaper/model/categoryModel.dart';
import 'package:freepaper/model/photo_model.dart';
import 'package:freepaper/screen/search.dart';
import 'package:freepaper/widget/categorieListTile.dart';
import 'package:freepaper/widget/custom.dart';
import 'package:freepaper/widget/loading.dart';
import 'package:freepaper/widget/search.dart';
import 'package:freepaper/widget/widget.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<PhotosModel> photos = [];
  TextEditingController searchController = TextEditingController();

  getTrendingWallpaper() async {
    String url = "https://api.pexels.com/v1/curated?per_page=30&page=1 ";
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
    getTrendingWallpaper();
    categories = getCategories();
    super.initState();
  }
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
              SearchWidget(
                name: "Search",
                controller: searchController,
                ontap: () {
                  pushScreen(
                    context,
                    Search(
                      search: searchController.text,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 80,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CategorieListTile(
                      imgUrl: categories[index].imgUrl,
                      title: categories[index].categorieName,
                    );
                  },
                ),
              ),
              photos.isEmpty ? Loading() : photosList(photos, context),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Photos provided By ",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontFamily: 'Overpass'),
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchURL("https://www.pexels.com/");
                    },
                    child: Container(
                        child: Text(
                          "Pexels",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontFamily: 'Overpass'),
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
