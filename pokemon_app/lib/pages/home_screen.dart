import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:pokemon_app/modules/pokemon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  List data =[];

  @override
  void initState() {
    super.initState();
    //fetchData();
    getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(
        //encode the URL
        Uri.parse(url));
    print(response.body);

    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['results'];
      print("data is here $data");
    });

    return "Success";
  }

  fetchData() async {
    var response = await http.get(Uri.parse(url));
    var decodedJson = jsonDecode(response.body);
    PokeHub pokeHub;
    pokeHub = PokeHub.fromJson(decodedJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Poke App"),
          backgroundColor: Colors.cyan,
          centerTitle: true,
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: [
            ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int i) {
                return Container(
                  padding: EdgeInsets.all(20.0),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(data[i]['name']),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
        drawer: Drawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.cyan,
          child: Icon(Icons.refresh),
        ));
  }
}
