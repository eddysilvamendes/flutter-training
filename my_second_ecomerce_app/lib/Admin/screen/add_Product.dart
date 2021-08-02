
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_second_ecomerce_app/Admin/models/db_list.dart';
import 'package:my_second_ecomerce_app/Admin/models/product_manage.dart';
import 'package:my_second_ecomerce_app/Admin/provider/product_provider.dart';
import 'package:my_second_ecomerce_app/User/widgets/commons.dart';
import 'package:my_second_ecomerce_app/User/widgets/splashScreen.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  DBList _dbList = DBList();
  ProductService _productDB = ProductService();
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
  List<String> colors = <String>[];
  // late FileImage _fileImage1;
  // late FileImage _fileImage2;
  // late FileImage _fileImage3;
  File? _pickedImage1;
  late PickedFile _image;
  bool isLoading = false;
  bool onSale = false;
  bool featured = false;

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
    final FirebaseStorage storage = FirebaseStorage.instance;
    final String picture1 =
        "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
    UploadTask task1 = storage.ref().child(picture1).putFile(_pickedImage1!);

    TaskSnapshot snapshot1 =
        await task1.whenComplete(() {}).then((snapshot) => snapshot);

    task1.whenComplete(() {}).then((snapshot3) async {
      imageUrl1 = await snapshot1.ref.getDownloadURL();

      _productDB
        ..uploadProduct({
          "name": productNameController.text,
          "price": double.parse(productPriceController.text),
          "sizes": selectedSizes,
          "colors": colors,
          "picture": imageUrl1,
          "quantity": int.parse(productQuantityController.text),
          "brand": _currentBrand,
          "category": _currentCategory,
          'sale': onSale,
          'featured': featured
        });
      _formKey.currentState!.reset();
      setState(() => isLoading = false);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Product Created");
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
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
          "Add Product",
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
                        decoration: InputDecoration(hintText: "Product Name"),
                      ),
                    ),
                    Text('Available Colors'),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              if (productProvider.selectedColors
                                  .contains('red')) {
                                productProvider.removeColor('red');
                              } else {
                                productProvider.addColors('red');
                              }
                              setState(() {
                                colors = productProvider.selectedColors;
                              });
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                  color: productProvider.selectedColors
                                          .contains('red')
                                      ? Colors.blue
                                      : grey,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              if (productProvider.selectedColors
                                  .contains('yellow')) {
                                productProvider.removeColor('yellow');
                              } else {
                                productProvider.addColors('yellow');
                              }
                              setState(() {
                                colors = productProvider.selectedColors;
                              });
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                  color: productProvider.selectedColors
                                          .contains('yellow')
                                      ? red
                                      : grey,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: Colors.yellow,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              if (productProvider.selectedColors
                                  .contains('blue')) {
                                productProvider.removeColor('blue');
                              } else {
                                productProvider.addColors('blue');
                              }
                              setState(() {
                                colors = productProvider.selectedColors;
                              });
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                  color: productProvider.selectedColors
                                          .contains('blue')
                                      ? red
                                      : grey,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              if (productProvider.selectedColors
                                  .contains('green')) {
                                productProvider.removeColor('green');
                              } else {
                                productProvider.addColors('green');
                              }
                              setState(() {
                                colors = productProvider.selectedColors;
                              });
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                  color: productProvider.selectedColors
                                          .contains('green')
                                      ? red
                                      : grey,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              if (productProvider.selectedColors
                                  .contains('white')) {
                                productProvider.removeColor('white');
                              } else {
                                productProvider.addColors('white');
                              }
                              setState(() {
                                colors = productProvider.selectedColors;
                              });
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                  color: productProvider.selectedColors
                                          .contains('white')
                                      ? red
                                      : grey,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              if (productProvider.selectedColors
                                  .contains('black')) {
                                productProvider.removeColor('black');
                              } else {
                                productProvider.addColors('black');
                              }
                              setState(() {
                                colors = productProvider.selectedColors;
                              });
                            },
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                  color: productProvider.selectedColors
                                          .contains('black')
                                      ? red
                                      : grey,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: CircleAvatar(
                                  backgroundColor: black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

//              select category

//
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: productQuantityController,
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(hintText: "Product Quantity"),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('Sale'),
                            SizedBox(
                              width: 10,
                            ),
                            Switch(
                                value: onSale,
                                onChanged: (value) {
                                  setState(() {
                                    onSale = value;
                                  });
                                }),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('Featured'),
                            SizedBox(
                              width: 10,
                            ),
                            Switch(
                                value: featured,
                                onChanged: (value) {
                                  setState(() {
                                    featured = value;
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),

                    FlatButton(
                      color: red,
                      textColor: white,
                      child: Text('add product'),
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
