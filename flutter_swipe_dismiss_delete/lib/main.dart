import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  final List<String> items =
      new List<String>.generate(30, (i) => "Items${i + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swipe to dismiss"),
      ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, int index) {
            final item = items[index];
            return Dismissible(
              key: Key(item),
              onDismissed: (direction) {
                items.removeAt(index);
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("Item Dismissed")));
              },
              background: Container(
                color: Colors.red,
              ),
              child: ListTile(
                title: Text("${items[index]}"),
              ),
            );
          }),
    );
  }
}
