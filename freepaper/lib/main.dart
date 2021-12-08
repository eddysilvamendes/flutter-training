// @dart=2.9
import 'dart:async';
import 'dart:io';

import 'package:animations/animations.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freepaper/screen/favorite.dart';
import 'package:freepaper/screen/home.dart';
import 'package:freepaper/screen/search.dart';
import 'package:freepaper/theme.dart';
import 'package:freepaper/widget/categorycard.dart';
import 'package:freepaper/widget/custom.dart';
import 'package:freepaper/widget/search.dart';
import 'package:freepaper/widget/widget.dart';
import 'package:overlay_support/overlay_support.dart';
void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  _enablePlatformOverrideForDesktop();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        title: 'FreePaper',
        debugShowCheckedModeBanner: false,
        //theme: ThemeData(primaryColor: kPrimaryColor),
        theme: lightThemeData(context),
        darkTheme: darkThemeData(context),
        home:
        MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController searchController = TextEditingController();
  int _selectedIndex = 0;



  @override
  Widget build(BuildContext context) {
    List<Widget> pageList = <Widget>[
      HomePage(),
      SearchWidget(
        name: "Search",
        controller: searchController,
        ontap: () {
          pushScreen(
            context,
            Search(
              search: searchController.text,
            ),
          );
        },
      ),
      CategoryCard(),
      Favorite()


    ];
    return Scaffold(
      //body: pageList[_selectedIndex],
      body: PageTransitionSwitcher(
        transitionBuilder: (
          child,
          primaryAnimation,
          secondaryAnimation,
        ) =>
            FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
        child: pageList[_selectedIndex],
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: "Search"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.category
            ),
            label: "Category"),
        BottomNavigationBarItem(
            icon: Icon(
                Icons.favorite
            ),
            label: "Favorite"),


      ],
    );
  }

}

// class MainScreen extends StatelessWidget {
//   final TextEditingController searchController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           appBar: AppBar(
//             title:  RichText(
//               textAlign: TextAlign.center,
//               text: TextSpan(
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 children: <TextSpan>[
//
//                   TextSpan(
//                     text: "Free",
//                     style: TextStyle(color: white),
//                   ),
//                   TextSpan(
//                     text: "Paper",
//                     style: TextStyle(color: blue),
//                   ),
//                 ],
//               ),
//             ),
//             centerTitle: true,
//             bottom: TabBar(
//
//               tabs: [
//                 Tab(
//                     icon: Icon(Icons.category, ),
//                   //text: "Category",
//                 ),
//                 Tab(
//                   icon: Icon(Icons.home, ),
//                   //text: "Home",
//                 ),
//                 Tab(
//                   icon: Icon(Icons.search, ),
//                   //text: "Search",
//                 ),
//               ],
//             ),
//           ),
//           body:TabBarView(
//
//             children: [
//             CategoryCard(),
//     HomePage(),
//     SearchWidget(name: "Search",
//     controller: searchController,
//     ontap: () {
//     pushScreen(
//     context,
//     Search(
//     search: searchController.text,
//     ),
//     );
//     },)
//           ],),
//         ),
//     );
//   }
// }
