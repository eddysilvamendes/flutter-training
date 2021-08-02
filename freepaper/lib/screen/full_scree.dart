// @dart=2.9

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freepaper/widget/custom.dart';
import 'package:freepaper/widget/widget.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FullScreen extends StatefulWidget {
  final String imgUrl;

  const FullScreen({Key key, @required this.imgUrl}) : super(key: key);

  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  var filePath;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void setHomeWallpaper(String img ) async {
    try {
      var file = await DefaultCacheManager().getSingleFile(img);
      int location = WallpaperManager.HOME_SCREEN;

          await WallpaperManager.setWallpaperFromFile(file.path, location);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Home Screen wallpaper has been Changed");

    } catch (e) {
      print(e);
    }
  }
  void setLockWallpaper(String img ) async {
    try {
      var file = await DefaultCacheManager().getSingleFile(img);
      int location = WallpaperManager.LOCK_SCREEN;

      await WallpaperManager.setWallpaperFromFile(file.path, location);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Lock Screen wallpaper has been Changed");

    } catch (e) {
      print(e);
    }
  }

  void setBothWallpaper(String img ) async {
    try {
      var file = await DefaultCacheManager().getSingleFile(img);
      int location = WallpaperManager.BOTH_SCREENS;

      await WallpaperManager.setWallpaperFromFile(file.path, location);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Both Screen wallpaper has been Changed");

    } catch (e) {
      print(e);
    }
  }

  void dialog(){
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Set Wallpaper", textAlign: TextAlign.center,),
            content: Container(
              height: MediaQuery.of(context).size.height /4,
              child: Column(
                children: [
                  myButton(context, "Home Screen",  (){
                    setHomeWallpaper(widget.imgUrl);
              }),
                  myButton(context, "Lock Screen",  (){
                    setLockWallpaper(widget.imgUrl);
                  }),
                  myButton(context, "Both Screen",  (){
                    setBothWallpaper(widget.imgUrl);
                  }),

                ],
              ),
            ),

          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imgUrl,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.height,
              child: kIsWeb
                  ? Image.network(widget.imgUrl, fit: BoxFit.cover)
                  : CachedNetworkImage(
                imageUrl: widget.imgUrl,
                placeholder: (context, url) => Container(
                  color: Color(0xfff5f8fd),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    if (kIsWeb) {
                      _launchURL(widget.imgUrl);
                    } else {
                      dialog();
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xff1C1B1B).withOpacity(0.8),
                        ),
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54, width: 1),
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            colors: [Color(0x36FFFFFF), Color(0x0FFFFFFF)],
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Set Wallpaper",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white70),
                            ),
                            Text(
                              kIsWeb
                                  ? "Image will open in new tab to download"
                                  : "Image will be saved in gallery",
                              style: TextStyle(
                                  fontSize: 10, color: Colors.white70),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(color: white),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }



}
