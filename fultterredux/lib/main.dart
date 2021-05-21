import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() {
  runApp(MyApp());
}

@immutable
class AppState {
  final counter;
  AppState(this.counter);
}

//Action
enum Action { Increment }

// Pure Function
AppState reducer(AppState prev, action) {
  if (action == Action.Increment) {
    return AppState(prev.counter + 1);
  }
  return prev;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final store = new Store(reducer, initialState: AppState(0));

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Redux App"),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                StoreConnector(
                  converter: (store).state.counter,
                  builder: (context, counter) => Text(
                    '$counter',
                    // ignore: deprecated_member_use
                    style: Theme.of(context).textTheme.display1,
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: StoreConnector<int, VoidCallback>(
            converter: (store) {
              return () => store.dispatch(Action.Increment);
            },
            builder: (context, callback) => FloatingActionButton(
              onPressed: callback,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          ),
        ));
  }
}
