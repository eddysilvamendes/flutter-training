import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late AppLifecycleState _appLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _appLifecycleState = state;
      print("My App State: _$_appLifecycleState");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: OrientationBuilder(
          builder: (context, orientation) {
            return Center(
              child: Text(
                _appLifecycleState.toString(),
                style: TextStyle(
                    fontSize: 22.0,
                    color: orientation == Orientation.portrait
                        ? Colors.blue
                        : Colors.red),
              ),
            );
          },
        ),
      ),
    );
  }
}
