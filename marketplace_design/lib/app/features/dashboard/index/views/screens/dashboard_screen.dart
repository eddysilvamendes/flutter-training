library dashboard;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:marketplace_design/app/features/dashboard/explore/views/screen/explore_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// bindings
part '../../bindings/dashboard_bindings.dart';

//controller
part '../../controllers/dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller.persistentTabController,
      screens: _buildScreen(),
      items: _buildNavbarsItems(),
      backgroundColor: Colors.white,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10),
        colorBehindNavBar: Colors.white,
      ),
      itemAnimationProperties: ItemAnimationProperties(
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
        animateTabTransition: true,
      ),
      navBarHeight: 70,
      //navBarStyle: NavBarStyle.style10,
    );
  }

  List<Widget> _buildScreen() {
    return [
      ExploreScreen(),
      Center(child: Text("Favorite")),
      Center(child: Text("Message")),
      Center(child: Text("Profile")),
    ];
  }

  List<PersistentBottomNavBarItem> _buildNavbarsItems() {
    return [
      _navBarItem(iconData: FontAwesomeIcons.thLarge, title: "Explore"),
      _navBarItem(iconData: FontAwesomeIcons.solidStar, title: "Favorite"),
      _navBarItem(
          iconData: FontAwesomeIcons.solidCommentAlt, title: "Messages"),
      _navBarItem(iconData: FontAwesomeIcons.userAlt, title: "Profile"),
    ];
  }

  PersistentBottomNavBarItem _navBarItem({
    required IconData iconData,
    required String title,
  }) {
    return PersistentBottomNavBarItem(
      icon: Icon(
        iconData,
        size: 20,
      ),
      title: title,
      activeColorPrimary: Color.fromRGBO(246, 246, 246, 1),
      inactiveColorPrimary: Color.fromRGBO(187, 193, 202, 1),
      activeColorSecondary: Theme.of(Get.context!).primaryColor,
      textStyle: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
