import 'dart:ffi';

import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Song> _songs;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() async {
    var songs = await MusicFinder.allSongs();
    songs = List.from(songs);

    setState(() {
      _songs = songs;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget home() {
      Scaffold(
        appBar: AppBar(
          title: Text("Music App"),
        ),
        body: ListView.builder(
            itemCount: _songs.length,
            itemBuilder: (context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text(_songs[index].title[0]),
                ),
                title: Text(_songs[index].title[0]),
              );
            }),
      );
    }

    return MaterialApp(
      home: home(),
    );
  }
}
