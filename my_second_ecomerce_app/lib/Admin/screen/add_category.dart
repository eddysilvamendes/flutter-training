
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_second_ecomerce_app/Admin/models/db_manage.dart';
import 'package:my_second_ecomerce_app/User/widgets/commons.dart';
import 'package:my_second_ecomerce_app/User/widgets/splashScreen.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  DBService _productDB = DBService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();

  File? _pickedImage1;

  late PickedFile _image;
  bool isLoading = false;

  Future<void> getImage(
      {required ImageSource source, required int imageNumber}) async {
    _image = (await ImagePicker().getImage(source: source))!;

    switch (imageNumber) {
      case 1:
        setState(() => _pickedImage1 = File(_image.path));
        break;
    }
  }

  Widget _displaychildImage1() {
    if (_pickedImage1 != null) {
      return Image.file(
        _pickedImage1!,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14.0, 60.0, 14.0, 60.0),
        child: Icon(
          Icons.add,
          color: grey,
        ),
      );
    }
  }

  void validateAndUpload() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      if (_pickedImage1 != null) {
        uploadImage();
      } else {
        setState(() => isLoading = true);
        Fluttertoast.showToast(msg: 'images must be provided');
      }
    }
  }

  void uploadImage() async {
    String imageUrl1;
    final FirebaseStorage storage = FirebaseStorage.instance;
    final String picture1 =
        "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
    UploadTask task1 = storage.ref().child(picture1).putFile(_pickedImage1!);

    TaskSnapshot snapshot1 =
        await task1.whenComplete(() {}).then((snapshot) => snapshot);

    task1.whenComplete(() {}).then((snapshot3) async {
      imageUrl1 = await snapshot1.ref.getDownloadURL();

      _productDB
        ..uploadCategory({
          "name": productNameController.text,
          "picture": imageUrl1,
        });
      _formKey.currentState!.reset();
      setState(() => isLoading = false);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Category Created");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            color: black,
          ),
        ),
        title: Text(
          "Add Categorie",
          style: TextStyle(
            color: black,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isLoading
              ? Splash()
              : Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 120,
                              child: OutlineButton(
                                  borderSide: BorderSide(
                                      color: grey.withOpacity(0.5), width: 2.5),
                                  onPressed: () {
                                    getImage(
                                        source: ImageSource.gallery,
                                        imageNumber: 1);
                                  },
                                  child: _displaychildImage1()),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Enter a product name with 10 characters maximun",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: red, fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: productNameController,
                        decoration: InputDecoration(hintText: "Category Name"),
                      ),
                    ),
                    FlatButton(
                      color: red,
                      textColor: white,
                      child: Text('Add Category'),
                      onPressed: () {
                        validateAndUpload();
                      },
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
