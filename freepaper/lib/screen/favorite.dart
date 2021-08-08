// @dart=2.9
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freepaper/db/notes_database.dart';
import 'package:freepaper/model/note.dart';
import 'package:freepaper/screen/full_screen.dart';
import 'package:freepaper/widget/custom.dart';
import 'package:freepaper/widget/loading.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<Note> notes = [];
  bool isLoading = false;

  @override
  void initState() {
    refreshNotes();
    super.initState();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    this.notes = await NotesDatabase.instance.readAllNotes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: isLoading
            ? Loading()
            : notes.isEmpty
                ? Center(
                    child: Text(
                      "No Favorites",
                      style: TextStyle(color: white, fontSize: 24),
                    ),
                  )
                : buildNotes(),
      ),
    );
  }

  Widget buildNotes() => GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 0.6,
      //padding: EdgeInsets.symmetric(horizontal: 16),
      mainAxisSpacing: 0.0,
      crossAxisSpacing: 0.0,
      children: notes.map((e) {
        return GridTile(
          child: InkWell(
            onTap: () {
              pushScreen(
                context,
                FullScreen(imgUrl: e.imgPath),
              );
            },
            child: Hero(
              tag: e.imgPath,
              child: Container(
                child: ClipRRect(
                  //borderRadius: BorderRadius.circular(16.0),
                  child: kIsWeb
                      ? Image.network(
                          e.imgPath,
                          height: 50,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                      : CachedNetworkImage(
                          imageUrl: e.imgPath,
                          placeholder: (context, url) => Container(
                                color: Color(0xfff5f8fd),
                              ),
                          fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        );
      }).toList());
}
