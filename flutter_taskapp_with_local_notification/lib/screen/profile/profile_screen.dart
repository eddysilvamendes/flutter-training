// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_taskapp_with_local_notification/controller/user_controller.dart';
import 'package:flutter_taskapp_with_local_notification/models/user_model.dart';
import 'package:flutter_taskapp_with_local_notification/screen/log/login_screen.dart';
import 'package:flutter_taskapp_with_local_notification/screen/profile/edit_profile_screen.dart';
import 'package:flutter_taskapp_with_local_notification/utils/theme.dart';
import 'package:flutter_taskapp_with_local_notification/utils/utility.dart';
import 'package:flutter_taskapp_with_local_notification/widgets/app_bar.dart';
import 'package:flutter_taskapp_with_local_notification/widgets/button.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User user = User();
  final UserController _userController = UserController();
  @override
  void initState() {
    super.initState();
    _userController.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(context),
      body: Obx(
        () {
          return ListView.builder(
              itemCount: _userController.userList.length,
              itemBuilder: (_, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*ProfileWidget(
                      imgPath: _userController.userList[index].imgPath!,
                      isEdit: false,
                      onTap: () async {
                        await Get.to(EditProfileScreen(
                            user: _userController.userList[index]));
                        _userController.getUser();
                      },
                    ),*/
                    Utility.imageFromBase64String(
                        _userController.userList[index].imgPath!, () async {
                      await Get.to(() => EditProfileScreen(
                          user: _userController.userList[index]));
                      _userController.getUser();
                    }, true),
                    SizedBox(height: 24),
                    _buildName(_userController.userList[index]),
                    SizedBox(height: 24),
                    Center(
                        child: MyButton(
                            onTap: () {
                              Get.to(() => LoginScreen());
                            },
                            label: "Upgrade To Pro")),
                    SizedBox(height: 24),
                    _buildNumber(),
                    SizedBox(height: 24),
                    _buildAbout(_userController.userList[index]),
                  ],
                );
              });
        },
      ),
    );
  }

  _buildName(User user) => Center(
        child: Column(
          children: [
            Text(user.username!.isEmpty ? "No Username" : user.username!,
                style: subHeadingStyle),
            SizedBox(height: 4),
            Text(user.email!.isEmpty ? "No Email" : user.email!,
                style: headingStyle.copyWith(fontSize: 16)),
          ],
        ),
      );

  _buildNumber() {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNumberButton(context, "4.8", "Ranking"),
          Container(
            height: 24,
            child: VerticalDivider(
              color: Colors.black,
            ),
          ),
          _buildNumberButton(context, "35", "Following"),
          Container(
            height: 24,
            child: VerticalDivider(
              color: Colors.black,
            ),
          ),
          _buildNumberButton(context, "50", "Followers"),
        ],
      ),
    );
  }

  _buildNumberButton(BuildContext context, String value, String label) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 4),
      onPressed: () {},
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            value,
            style: subHeadingStyle.copyWith(fontSize: 20),
          ),
          Text(
            label,
            style: subHeadingStyle.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }

  _buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About",
              style: subHeadingStyle,
            ),
            SizedBox(height: 16),
            Text(
              user.about!.isEmpty ? "No Discription" : user.about!,
              style: titleStyle.copyWith(height: 1.4),
            ),
          ],
        ),
      );
}
