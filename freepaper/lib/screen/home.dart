// @dart=2.9
import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:freepaper/data/data.dart';
import 'package:freepaper/model/categoryModel.dart';
import 'package:freepaper/model/photo_model.dart';
import 'package:freepaper/screen/search.dart';
import 'package:freepaper/widget/categorycard.dart';
import 'package:freepaper/widget/custom.dart';
import 'package:freepaper/widget/loading.dart';
import 'package:freepaper/widget/widget.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PhotosModel> photos = [];
  TextEditingController searchController = TextEditingController();

  void showConnectivitySnackBar(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    final message = hasInternet
        ? 'You have again ${result.toString()}'
        : 'Please Connect to internet';
    final color = hasInternet ? Colors.green : Colors.red;

    Utils.showTopSnackBar(context, message, color);
  }

  getTrendingWallpaper() async {
    String url = "https://api.pexels.com/v1/curated?per_page=80&page=1 ";
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
  StreamSubscription subscription;


  @override
  void initState() {
    subscription = Connectivity().onConnectivityChanged.listen((showConnectivitySnackBar));
    
    getTrendingWallpaper();
    super.initState();
  }
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
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
      appBar: AppBar(
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            children: <TextSpan>[
              TextSpan(
                text: "Free",
              ),
              TextSpan(
                text: "Paper",
                style: TextStyle(color: blue),
              ),
            ],
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
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
