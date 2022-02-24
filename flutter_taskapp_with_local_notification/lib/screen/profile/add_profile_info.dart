// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_taskapp_with_local_notification/controller/user_controller.dart';
import 'package:flutter_taskapp_with_local_notification/models/user_model.dart';
import 'package:flutter_taskapp_with_local_notification/screen/profile/profile_screen.dart';

import 'package:flutter_taskapp_with_local_notification/utils/utility.dart';
import 'package:flutter_taskapp_with_local_notification/widgets/app_bar.dart';
import 'package:flutter_taskapp_with_local_notification/widgets/button.dart';
import 'package:flutter_taskapp_with_local_notification/widgets/input_field.dart';
import 'package:flutter_taskapp_with_local_notification/widgets/profile.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProfileScreen extends StatefulWidget {
  const AddProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  _AddProfileScreenState createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  final ImagePicker _picker = ImagePicker();

  UserController userController = Get.put(UserController());

  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _about = TextEditingController();
  String imgString = '';

  //TODO: convert img to strong

  Future<void> getImage({required ImageSource source}) async {
    await _picker.pickImage(source: source).then((value) async {
      imgString = Utility.base64String(await value!.readAsBytes());
    });
  }

  Future<void> myDialogBox() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  onTap: () {
                    getImage(source: ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                  title: Text("Pick From Camera"),
                ),
                ListTile(
                  leading: Icon(Icons.photo),
                  onTap: () {
                    getImage(source: ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                  title: Text("Pick From Galery"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(context),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imgPath:
                "https://www.shareicon.net/data/128x128/2016/09/15/829466_man_512x512.png",
            isEdit: true,
            onTap: () async {
              myDialogBox();
            },
          ),
          SizedBox(height: 24),
          MyInputField(
            title: "Full Name",
            hint: "Enter your username...",
            controller: _username,
          ),
          MyInputField(
            title: "Email",
            hint: "Enter your email...",
            controller: _email,
          ),
          MyInputField(
            title: "About",
            hint: "Enter your Discription...",
            controller: _about,
            maxLines: 5,
          ),
          SizedBox(height: 24),
          MyButton(
              onTap: () {
                _saveData();
                print(imgString);
              },
              label: "Save")
        ],
      ),
    );
  }

  void _saveData() async {
    print("Ener Save");
    await userController.addUser(
      user: User(
        username: _username.text,
        about: _about.text,
        email: _email.text,
        imgPath: imgString,
      ),
    );
    Get.off(() => ProfileScreen());
    userController.getUser();
    Get.snackbar(
      "Created",
      "User info has been created!",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }
}
