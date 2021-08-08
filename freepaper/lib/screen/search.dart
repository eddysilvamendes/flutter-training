// @dart=2.9
import 'package:flutter/material.dart';
import 'package:freepaper/data/data.dart';
import 'package:freepaper/model/photo_model.dart';
import 'package:freepaper/widget/custom.dart';
import 'package:freepaper/widget/widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Search extends StatefulWidget {
  final String search;

  const Search({Key key, @required this.search}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<PhotosModel> photos = [];
  TextEditingController searchController = TextEditingController();

  getsearchWallpaper(String query) async {
    String url =
        "https://api.pexels.com/v1/search?query=$query&per_page=80&page=1";
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
    getsearchWallpaper(widget.search);

    searchController.text = widget.search;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Text(
                widget.search.toUpperCase(),
                style: TextStyle(color: white),
              ),
              Divider(
                color: white,
              ),
              photosList(photos, context),
            ],
          ),
        ),
      ),
    );
  }
}
