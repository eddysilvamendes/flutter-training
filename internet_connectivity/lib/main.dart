import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future getData() async {
    http.Response response =
        await http.get("https://jsonplaceholder.typicode.com/posts/");

    // ignore: deprecated_member_use
    if (response.statusCode == HttpStatus.OK) {
      var result = jsonDecode(response.body);
      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connectivity"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var mydata = snapshot.data;
              return ListView.builder(
                itemCount: mydata.length,
                itemBuilder: (context, i) => ListTile(
                  title: Text(mydata[i]['title']),
                  subtitle: Text(mydata[i]['body']),
                ),
              );
            } else {
              return Center(
                child: new CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
