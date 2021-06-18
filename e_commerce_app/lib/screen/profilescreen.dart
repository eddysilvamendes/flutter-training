import 'package:e_commerce_app/model/usermodel.dart';
import 'package:e_commerce_app/provider/product_provider.dart';
import 'package:e_commerce_app/screen/home.dart';
import 'package:e_commerce_app/widgets/mybutton.dart';
import 'package:e_commerce_app/widgets/notification_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProductProvider productProvider;
  File _pickedImage;
  PickedFile _image;

  Future<void> getImage({ImageSource source}) async {
    _image = await ImagePicker().getImage(source: source);

    if (_image != null) {
      _pickedImage = File(_image.path);
    }
  }

  String imageUrl;
  void _uploadImage({File image}) async {
    User user = FirebaseAuth.instance.currentUser;
    Reference reference =
        FirebaseStorage.instance.ref().child("UserImage/${user.uid}");
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    imageUrl = await snapshot.ref.getDownloadURL();
  }

  TextStyle mystyleField = TextStyle(fontSize: 17, color: Colors.black45);

  TextStyle mystyleData = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);

  Widget _buildSingleContainer({String startText, String endText}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              startText,
              style: mystyleField,
            ),
            Text(
              endText,
              style: mystyleData,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleTextFormField({String name}) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: name,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  bool edit = false;

  Widget _buildContainerPart() {
    List<UserModel> userModel = productprovider.getUserModelList;
    return Column(
      children: userModel.map((e) {
        return Container(
          height: 350,
          child: Column(
            children: [
              _buildSingleContainer(
                startText: "Name",
                endText: e.userName,
              ),
              _buildSingleContainer(
                startText: "Email",
                endText: e.userEmail,
              ),
              _buildSingleContainer(
                startText: "Gender",
                endText: e.userGender,
              ),
              _buildSingleContainer(
                startText: "Phone Number",
                endText: e.userPhoneNumber,
              ),
              _buildSingleContainer(
                startText: "Adress",
                endText: e.userAdress,
              ),
            ],
          ),
        );
      }).toList(),
    );
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

  Widget _buildTextFormPart() {
    List<UserModel> userModel = productprovider.getUserModelList;
    return Column(
      children: userModel.map((e) {
        return Container(
          height: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSingleTextFormField(name: e.userName),
              _buildSingleTextFormField(
                name: e.userEmail,
              ),
              _buildSingleTextFormField(
                name: e.userGender,
              ),
              _buildSingleTextFormField(
                name: e.userGender,
              ),
              _buildSingleTextFormField(
                name: e.userAdress,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        leading: edit == true
            ? IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.redAccent,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    edit = false;
                  });
                },
              )
            : IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black45,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => HomePage(),
                      ),
                    );
                  });
                },
              ),
        backgroundColor: Colors.white,
        elevation: 0.8,
        actions: [
          edit == false
              ? NotificationButton()
              : IconButton(
                  onPressed: () {
                    _uploadImage(image: _pickedImage);
                    setState(() {
                      edit = false;
                    });
                  },
                  icon: Icon(
                    Icons.check,
                    size: 30,
                    color: Color(0xff746bc9),
                  ),
                ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        maxRadius: 65,
                        backgroundImage: _pickedImage == null
                            ? NetworkImage(
                                "https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg")
                            : FileImage(_pickedImage),
                      ),
                    ],
                  ),
                ),
                edit == true
                    ? Padding(
                        padding: const EdgeInsets.only(left: 200, top: 100),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              myDialogBox();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                Icons.camera_alt,
                                color: Color(0xff746bc9),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 350,
                  child: edit == true
                      ? _buildTextFormPart()
                      : _buildContainerPart(),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 200,
                    child: edit == false
                        ? MyButton(
                            name: "Edit Profile",
                            onPressed: () {
                              setState(() {
                                edit = true;
                              });
                            },
                          )
                        : Container(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
