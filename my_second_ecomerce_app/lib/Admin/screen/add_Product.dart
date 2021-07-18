import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_second_ecomerce_app/Admin/models/db_list.dart';
import 'package:my_second_ecomerce_app/Admin/models/product_manage.dart';
import 'package:my_second_ecomerce_app/commons/commons.dart';
import 'package:my_second_ecomerce_app/widgets/myButtons.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  DBList _dbList = DBList();
  ProductDBManage _productDB = ProductDBManage();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DocumentSnapshot> brand = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String? _currentCategory;
  String? _currentBrand;
  List<String> selectedSizes = <String>[];
  // late FileImage _fileImage1;
  // late FileImage _fileImage2;
  // late FileImage _fileImage3;
  File? _pickedImage1;
  File? _pickedImage2;
  File? _pickedImage3;
  late PickedFile _image;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _getCategories();
    _getBrand();
//    _getBrands();
    //categoriesDropDown = getCategoriesDropdown();
  }

//======================Category DropDown=============================
  _getCategories() async {
    List<DocumentSnapshot> data = await _dbList.getCategoryList();

    setState(() {
      categories = data;
      categoriesDropDown = getCategoriesDropdown();
      _currentCategory = categories[0]['name'];
    });
  }

  List<DropdownMenuItem<String>> getCategoriesDropdown() {
    List<DropdownMenuItem<String>> items = [];
    for (int i = 0; i < categories.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(categories[i]['name']),
                value: categories[i]['name']));
      });
    }
    return items;
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }

//======================================================================
//======================Brand DropDown=============================
  _getBrand() async {
    List<DocumentSnapshot> data = await _dbList.getBrandList();

    setState(() {
      brand = data;
      brandsDropDown = getBrandDropdown();
      _currentBrand = brand[0]['name'];
    });
  }

  List<DropdownMenuItem<String>> getBrandDropdown() {
    List<DropdownMenuItem<String>> items = [];
    for (int i = 0; i < brand.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(brand[i]['name']), value: brand[i]['name']));
      });
    }
    return items;
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() => _currentBrand = selectedBrand);
  }

//======================================================================
  void changeSelectedSize(String size) {
    if (selectedSizes.contains(size)) {
      setState(() {
        selectedSizes.remove(size);
      });
    } else {
      setState(() {
        selectedSizes.insert(0, size);
      });
    }
  }

  Future<void> getImage(
      {required ImageSource source, required int imageNumber}) async {
    _image = (await ImagePicker().getImage(source: source))!;

    switch (imageNumber) {
      case 1:
        setState(() => _pickedImage1 = File(_image.path));
        break;
      case 2:
        setState(() => _pickedImage2 = File(_image.path));
        break;
      case 3:
        setState(() => _pickedImage3 = File(_image.path));
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

  Widget _displaychildImage2() {
    if (_pickedImage2 != null) {
      return Image.file(
        _pickedImage2!,
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

  Widget _displaychildImage3() {
    if (_pickedImage3 != null) {
      return Image.file(
        _pickedImage3!,
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
      if (_pickedImage1 != null &&
          _pickedImage2 != null &&
          _pickedImage3 != null) {
        if (selectedSizes.isNotEmpty) {
          uploadImage();
        } else {
          setState(() => isLoading = true);
          Fluttertoast.showToast(msg: 'select atleast one size');
        }
      } else {
        setState(() => isLoading = true);
        Fluttertoast.showToast(msg: 'all the images must be provided');
      }
    }
  }

  void uploadImage() async {
    String imageUrl1;
    String imageUrl2;
    String imageUrl3;
    final FirebaseStorage storage = FirebaseStorage.instance;
    final String picture1 =
        "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
    UploadTask task1 = storage.ref().child(picture1).putFile(_pickedImage1!);
    final String picture2 =
        "2${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
    UploadTask task2 = storage.ref().child(picture2).putFile(_pickedImage2!);
    final String picture3 =
        "3${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
    UploadTask task3 = storage.ref().child(picture3).putFile(_pickedImage3!);

    TaskSnapshot snapshot1 =
        await task1.whenComplete(() {}).then((snapshot) => snapshot);
    TaskSnapshot snapshot2 =
        await task2.whenComplete(() {}).then((snapshot) => snapshot);
    //TaskSnapshot snapshot3 = await task3.whenComplete((){}).then((snapshot)=>snapshot);

    task3.whenComplete(() {}).then((snapshot3) async {
      imageUrl1 = await snapshot1.ref.getDownloadURL();
      imageUrl2 = await snapshot2.ref.getDownloadURL();
      imageUrl3 = await snapshot3.ref.getDownloadURL();

      List<String> imageList = [imageUrl1, imageUrl2, imageUrl3];

      _productDB.uploadProduct(
        productName: productNameController.text,
        productBrand: _currentBrand.toString(),
        productQuantity: int.parse(productQuantityController.text),
        productCategory: _currentCategory.toString(),
        productSizes: selectedSizes,
        productImages: imageList,
        productPrice: double.parse(productPriceController.text),
      );
      _formKey.currentState!.reset();
      setState(() => isLoading = false);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Product Created");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: white,
        leading: Icon(
          Icons.close,
          color: black,
        ),
        title: Text(
          "Add Product",
          style: TextStyle(
            color: black,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: OutlineButton(
                                onPressed: () {
                                  getImage(
                                      source: ImageSource.gallery,
                                      imageNumber: 1);
                                  //Navigator.of(context).pop();
                                  // _selectImage(
                                  //     ImagePicker()
                                  //         .getImage(source: ImageSource.gallery),
                                  //     3);
                                },
                                borderSide: BorderSide(
                                  color: grey.withOpacity(0.5),
                                  width: 2.5,
                                ),
                                child: _displaychildImage1(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: OutlineButton(
                                onPressed: () {
                                  getImage(
                                      source: ImageSource.gallery,
                                      imageNumber: 2);
                                },
                                borderSide: BorderSide(
                                  color: grey.withOpacity(0.5),
                                  width: 2.5,
                                ),
                                child: _displaychildImage2(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: OutlineButton(
                                onPressed: () {
                                  getImage(
                                      source: ImageSource.gallery,
                                      imageNumber: 3);
                                },
                                borderSide: BorderSide(
                                  color: grey.withOpacity(0.5),
                                  width: 2.5,
                                ),
                                child: _displaychildImage3(),
                              ),
                            ),
                          ),
                        ],
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
                decoration: InputDecoration(hintText: "Product Name"),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Category",
                    style: TextStyle(color: red),
                  ),
                ),
                DropdownButton(
                  items: categoriesDropDown,
                  onChanged: (value) {
                    setState(() {
                      _currentCategory = value as String?;
                    });
                  },
                  value: _currentCategory,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Brand",
                    style: TextStyle(color: red),
                  ),
                ),
                DropdownButton(
                  items: brandsDropDown,
                  onChanged: (value) {
                    setState(() {
                      _currentBrand = value as String?;
                    });
                  },
                  value: _currentBrand,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: productQuantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Product Quantity"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: productPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Product Price"),
              ),
            ),
            Text("Available Sizes"),
            Row(
              children: [
                Checkbox(
                    value: selectedSizes.contains('XS'),
                    onChanged: (value) => changeSelectedSize('XS')),
                Text('XS'),
                Checkbox(
                    value: selectedSizes.contains('S'),
                    onChanged: (value) => changeSelectedSize('S')),
                Text('S'),
                Checkbox(
                    value: selectedSizes.contains('M'),
                    onChanged: (value) => changeSelectedSize('M')),
                Text('M'),
                Checkbox(
                    value: selectedSizes.contains('L'),
                    onChanged: (value) => changeSelectedSize('L')),
                Text('L'),
                Checkbox(
                    value: selectedSizes.contains('XL'),
                    onChanged: (value) => changeSelectedSize('XL')),
                Text('XL'),
                Checkbox(
                    value: selectedSizes.contains('XXL'),
                    onChanged: (value) => changeSelectedSize('XXL')),
                Text('XXL'),
              ],
            ),
            Row(
              children: <Widget>[
                Checkbox(
                    value: selectedSizes.contains('28'),
                    onChanged: (value) => changeSelectedSize('28')),
                Text('28'),
                Checkbox(
                    value: selectedSizes.contains('30'),
                    onChanged: (value) => changeSelectedSize('30')),
                Text('30'),
                Checkbox(
                    value: selectedSizes.contains('32'),
                    onChanged: (value) => changeSelectedSize('32')),
                Text('32'),
                Checkbox(
                    value: selectedSizes.contains('34'),
                    onChanged: (value) => changeSelectedSize('34')),
                Text('34'),
                Checkbox(
                    value: selectedSizes.contains('36'),
                    onChanged: (value) => changeSelectedSize('36')),
                Text('36'),
                Checkbox(
                    value: selectedSizes.contains('38'),
                    onChanged: (value) => changeSelectedSize('38')),
                Text('38'),
              ],
            ),
            Row(
              children: <Widget>[
                Checkbox(
                    value: selectedSizes.contains('40'),
                    onChanged: (value) => changeSelectedSize('40')),
                Text('40'),
                Checkbox(
                    value: selectedSizes.contains('42'),
                    onChanged: (value) => changeSelectedSize('42')),
                Text('42'),
                Checkbox(
                    value: selectedSizes.contains('44'),
                    onChanged: (value) => changeSelectedSize('44')),
                Text('44'),
                Checkbox(
                    value: selectedSizes.contains('46'),
                    onChanged: (value) => changeSelectedSize('46')),
                Text('46'),
                Checkbox(
                    value: selectedSizes.contains('48'),
                    onChanged: (value) => changeSelectedSize('48')),
                Text('48'),
                Checkbox(
                    value: selectedSizes.contains('50'),
                    onChanged: (value) => changeSelectedSize('50')),
                Text('50'),
              ],
            ),
            LoginButton(
              color: red,
              imgPath: "images/googleLogo.png",
              name: "Submit",
              onPressed: () {
                validateAndUpload();
              },
            ),
          ],
        ),
      ),
    );
  }
}
