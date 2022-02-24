import 'package:flutter/material.dart';
import 'package:flutter_taskapp_with_local_notification/screen/settings/account_screen.dart';
import 'package:flutter_taskapp_with_local_notification/services/theme_service.dart';

import 'package:flutter_taskapp_with_local_notification/widgets/app_bar.dart';
import 'package:flutter_taskapp_with_local_notification/widgets/setting_widget.dart';
import 'package:get/get.dart';

class NewSettingScreen extends StatefulWidget {
  const NewSettingScreen({Key? key}) : super(key: key);

  @override
  _NewSettingScreenState createState() => _NewSettingScreenState();
}

class _NewSettingScreenState extends State<NewSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(context),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(30),
          children: [
            SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text("DarkMode"),
                  subtitle: Text("Turn DarkMode"),
                  value: Get.isDarkMode,
                  onChanged: (value) {
                    ThemeService().switchTheme();
                  },
                  secondary: iconWidget(Icons.dark_mode, Colors.blueAccent),
                ),
                Text(
                  "General".toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                buildContent(
                  name: "Account Settings",
                  color: Colors.green,
                  icon: Icons.person,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                    color: Colors.grey,
                  ),
                  ontap: () => Get.to(() => AccountScreen()),
                ),
                SizedBox(height: 20),
                buildContent(
                  name: "Log Out",
                  color: Colors.blueAccent,
                  icon: Icons.logout,
                  child: Container(),
                ),
                SizedBox(height: 20),
                buildContent(
                  name: "Delete Account",
                  color: Colors.pink,
                  icon: Icons.delete,
                  child: Container(),
                ),
                SizedBox(height: 32),
                Text(
                  "Feedback".toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                buildContent(
                  name: "Report a bug",
                  color: Colors.teal,
                  icon: Icons.bug_report,
                  child: Container(),
                ),
                SizedBox(height: 20),
                buildContent(
                  name: "Send Feedback",
                  color: Colors.purple,
                  icon: Icons.thumb_up,
                  child: Container(),
                  ontap: () => print("object"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
