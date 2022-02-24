// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_taskapp_with_local_notification/controller/user_controller.dart';
import 'package:flutter_taskapp_with_local_notification/models/user_model.dart';
import 'package:flutter_taskapp_with_local_notification/utils/utility.dart';
import 'package:flutter_taskapp_with_local_notification/widgets/app_bar.dart';
import 'package:flutter_taskapp_with_local_notification/widgets/button.dart';
import 'package:flutter_taskapp_with_local_notification/widgets/input_field.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ImagePicker _picker = ImagePicker();

  UserController userController = Get.put(UserController());

  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _about = TextEditingController();
  String imgString = '';

  //TODO: fix this part

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
  void initState() {
    super.initState();
    _username = TextEditingController(text: widget.user.username);
    _email = TextEditingController(text: widget.user.email);
    _about = TextEditingController(text: widget.user.about);
  }

  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _about.dispose();
    super.dispose();
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
          Utility.imageFromBase64String(widget.user.imgPath!, () async {
            myDialogBox();
          }, true),
          /* ProfileWidget(
            imgPath: widget.user.imgPath!,
            isEdit: true,
            onTap: () async {
              myDialogBox();
            },
          ),*/
          SizedBox(height: 24),
          MyInputField(
            title: "Full Name",
            hint: widget.user.username!.isEmpty
                ? "Enter your username..."
                : widget.user.username!,
            controller: _username,
          ),
          MyInputField(
            title: "Email",
            hint: widget.user.email!.isEmpty
                ? "Enter your email..."
                : widget.user.email!,
            controller: _email,
          ),
          MyInputField(
            title: "About",
            hint: widget.user.about!.isEmpty
                ? "Enter your Discription..."
                : widget.user.about!,
            controller: _about,
            maxLines: 5,
          ),
          SizedBox(height: 24),
          MyButton(
              onTap: () {
                _updateData();
              },
              label: "Update")
        ],
      ),
    );
  }

  void _updateData() {
    userController.updateUsers(
        widget.user.id!, _username.text, _email.text, _about.text, imgString);
    Get.back();
    userController.getUser();
    Get.snackbar(
      "Updated",
      "User info has been updated!",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }
}
