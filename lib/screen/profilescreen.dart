import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/model/usermodel.dart';
import 'package:e_commerce_app/provider/product_provider.dart';
import 'package:e_commerce_app/screen/home.dart';
import 'package:e_commerce_app/screen/signup.dart';
import 'package:e_commerce_app/widgets/mybutton.dart';
import 'package:e_commerce_app/widgets/mytextformfield.dart';
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
  //ProductProvider productProvider;
  // ignore: unused_field
  File _pickedImage;
  PickedFile _image;
  User user = FirebaseAuth.instance.currentUser;
  Reference reference;
  TaskSnapshot snapshot;
  UploadTask uploadTask;
  String userUid;
  String userImage;
  String imageUrl;
  UserModel userModel;
  bool centerCircle = false;
  var imageMap;
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController adress = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> getImage({ImageSource source}) async {
    _image = await ImagePicker().getImage(source: source);

    if (_image != null) {
      setState(() {
        _pickedImage = File(_image.path);
      });
    }
  }

  // ignore: unused_element
  void _uploadImage({File image}) async {
    if (image == null) return;

    reference = FirebaseStorage.instance.ref().child("UserImage/${user.uid}");
    print(reference.toString());
    uploadTask = reference.putFile(image);
    snapshot = await uploadTask.whenComplete(() {});
    imageUrl = await snapshot.ref.getDownloadURL();
    //return imageUrl;
  }

  void userDetailUpdate() async {
    // setState(() {
    //   centerCircle = true;
    // });
    // _pickedImage != null
    //     ? imageMap =  _uploadImage(image: _pickedImage)
    //     : Container();

    FirebaseFirestore.instance.collection("User").doc(user.uid).update({
      "UserName": userName.text,
      "UserGender": isMale == true ? "Male" : "Female",
      "Phone": phoneNumber.text,
      "UserImage": imageUrl == null
          ? "https://i.pinimg.com/originals/73/16/f5/7316f550de9ca0045e3d8d98a5bb5e44.png"
          : imageUrl,
      "Adress": adress.text
    });
    // setState(() {
    //   centerCircle = false;
    // });
  }

  void validation() async {
    if (userName.text.isEmpty && phoneNumber.text.isEmpty) {
      _scaffoldKey.currentState
          // ignore: deprecated_member_use
          ?.showSnackBar(SnackBar(content: Text(" Flied Are Empty")));
    } else if (userName.text.length < 6) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Username Is Too Short"),
        ),
      );
    } else if (phoneNumber.text.length < 7 || phoneNumber.text.length > 7) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text("Phone Number Must Be 7 "),
        ),
      );
    } else {
      // _uploadImage(image: _pickedImage);
      userDetailUpdate();
      setState(() {
        edit = false;
      });
    }
  }

  TextStyle mystyleField = TextStyle(fontSize: 17, color: Colors.black45);

  TextStyle mystyleData = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);

  // Widget _buildSingleContainer({String startText, String endText}) {
  //   return Card(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  //     child: Container(
  //       height: 50,
  //       padding: EdgeInsets.symmetric(horizontal: 20),
  //       width: double.infinity,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(30),
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             startText,
  //             style: mystyleField,
  //           ),
  //           Text(
  //             endText,
  //             style: mystyleData,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSingleContainer(
      {Color color, String startText, String endText}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 55,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: edit == true ? color : Colors.white,
          borderRadius: edit == false
              ? BorderRadius.circular(30)
              : BorderRadius.circular(0),
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              startText,
              style: TextStyle(fontSize: 17, color: Colors.black45),
            ),
            Text(
              endText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
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
    userName = TextEditingController(text: userModel.userName);
    phoneNumber = TextEditingController(text: userModel.userPhoneNumber);
    adress = TextEditingController(text: userModel.userAdress);
    if (userModel.userGender == "Male") {
      isMale = true;
    } else {
      isMale = false;
    }

    return Container(
      height: 350,
      child: Column(
        children: [
          _buildSingleContainer(
            startText: "Name",
            endText: userModel.userName,
          ),
          _buildSingleContainer(
            startText: "Email",
            endText: userModel.userEmail,
          ),
          _buildSingleContainer(
            startText: "Gender",
            endText: userModel.userGender,
          ),
          _buildSingleContainer(
            startText: "Phone Number",
            endText: userModel.userPhoneNumber,
          ),
          _buildSingleContainer(
            startText: "Adress",
            endText: userModel.userAdress,
          ),
        ],
      ),
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
    return Container(
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyTextFormField(
            name: "UserName",
            controller: userName,
          ),
          _buildSingleContainer(
            color: Colors.grey[300],
            endText: userModel.userEmail,
            startText: "Email",
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isMale = !isMale;
              });
            },
            child: _buildSingleContainer(
              color: Colors.white,
              endText: isMale == true ? "Male" : "Female",
              startText: "Gender",
            ),
          ),
          MyTextFormField(
            name: "Phone Number",
            controller: phoneNumber,
          ),
          MyTextFormField(
            name: "Adress",
            controller: adress,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
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
                    print(adress.text);
                    validation();
                    // setState(() {
                    //   edit = false;
                    // });
                  },
                  icon: Icon(
                    Icons.check,
                    size: 30,
                    color: Color(0xff746bc9),
                  ),
                ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("User").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var myDoc = snapshot.data.docs;
            myDoc.forEach((checkDocs) {
              if (checkDocs.data()["UserId"] == user.uid) {
                userModel = UserModel(
                  userEmail: checkDocs.data()["Email"],
                  userGender: checkDocs.data()["UserGender"],
                  userName: checkDocs.data()["UserName"],
                  userPhoneNumber: checkDocs.data()["Phone"],
                  userAdress: checkDocs.data()["Adress"],
                  userImage: checkDocs.data()["UserImage"],
                );
              }
            });
            return Container(
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
                              backgroundImage: userModel.userImage == null
                                  ? NetworkImage(
                                      "https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg")
                                  : NetworkImage(userModel.userImage),
                            ),
                          ],
                        ),
                      ),
                      edit == true
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 200, top: 100),
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
            );
          }),
    );
  }
}
