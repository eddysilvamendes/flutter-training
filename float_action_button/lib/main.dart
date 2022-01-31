import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Float Action Button"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        
      ),
      floatingActionButton: SpeedDial(
        
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(child: Icon(Icons.mail), label: "mail"),
          SpeedDialChild(child: Icon(Icons.alarm), label: "alarm"),
          SpeedDialChild(child: Icon(Icons.copy), label: "copy"),
        ],
      ),
    );
  }
}
