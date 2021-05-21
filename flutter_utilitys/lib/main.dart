import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// Tab Var View Navigation bar met 2 (inside the app bar)
class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Util App"),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.favorite),
            ),
            Tab(
              icon: Icon(Icons.email),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: TabBarView(
        children: [NewPage("First"), NewPage("Second")],
        controller: tabController,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.orangeAccent,
        onPressed: () => print("FAB Pressed "),
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  final String title;
  NewPage(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(title),
      ),
    );
  }
}

/* // Tab Var View Navigation bar met 1
class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Util App"),
      ),
      body: TabBarView(
        children: [NewPage("First"), NewPage("Second")],
        controller: tabController,
      ),
      bottomNavigationBar: Material(
        color: Colors.teal,
        child: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.favorite),
            ),
            Tab(
              icon: Icon(Icons.email),
            )
          ],
        ),
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  final String title;
  NewPage(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(title),
      ),
    );
  }
} */

/* // Steps Utilitys Exampls
class _HomePageState extends State<HomePage> {
  int current_step = 0;

  List<Step> my_steps = [
    Step(title: Text("Step 1"), content: Text("Som Content 1"), isActive: true),
    Step(title: Text("Step 2"), content: Text("Som Content 2"), isActive: true),
    Step(title: Text("Step 3"), content: Text("Som Content 3"), isActive: true)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Util App"),
      ),
      body: Stepper(
        steps: my_steps,
        currentStep: this.current_step,
        type: StepperType.vertical,
      ),
      //MyBody()
    );
  }
} */

/* // Raised bottum and Snack Bar Exmaple
class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Util App"),
      ),
      body: 
      MyBody()
    );
  }
}

class MyBody extends StatelessWidget {
  AlertDialog dialog = new AlertDialog(
    content: Text("Dialog is Up...", style: TextStyle(fontSize: 30.0),),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        // ignore: deprecated_member_use
        child: RaisedButton(
          child: Text("Cick me", style: TextStyle(color: Colors.white)),
          // ignore: deprecated_member_use
           onPressed: () => Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("You Click Me"),
            duration: Duration(seconds: 3),
          )), 
          color: Colors.redAccent,
        ),
      ),
    );
  }
}

 */
