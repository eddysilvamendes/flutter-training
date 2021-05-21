import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My First App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              print('It work');
            },
          )
        ],
        //centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Text('Click'),
        backgroundColor: Colors.red[600],
      ),
    );
  }
}


/* Some body widget

IconButton(
          onPressed: (){
            print('Hello');
          },
          icon: Icon(Icons.alternate_email),
          color: Colors.amber
        ),
        Image.asset('assets/space-3.jpg'),

RaisedButton.icon(
        onPressed: (){
          print('Y Click Me');
        },
          icon: Icon(
            Icons.mail
          ),
          label: Text('Mail me'),
          color: Colors.amber,
        ),


*/