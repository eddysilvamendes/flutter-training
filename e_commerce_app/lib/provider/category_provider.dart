import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/model/categoryicon.dart';
import 'package:e_commerce_app/model/product.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  Product shirtData;
  List<Product> shirt = [];
  Product dressData;
  List<Product> dress = [];
  Product shoesData;
  List<Product> shoes = [];
  Product tieData;
  List<Product> tie = [];
  Product pantData;
  List<Product> pant = [];

/*==============================================================================

******************************CategoryIcon**************************************
==============================================================================*/
  List<CategoryIcon> dressIcon = [];
  CategoryIcon dressIconData;

  Future<void> getDressIconData() async {
    List<CategoryIcon> newList = [];
    QuerySnapshot dressIconSnapShot = await FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("dUeQcsaboB7shChdJXdo")
        .collection("dress")
        .get();

    dressIconSnapShot.docs.forEach(
      (element) {
        dressIconData = CategoryIcon(
          image: element["image"],
        );
        newList.add(dressIconData);
      },
    );
    dressIcon = newList;
    notifyListeners();
  }

  List<CategoryIcon> get getDressIconList {
    return dressIcon;
  }

  //-------------------------------------------
  List<CategoryIcon> shirtIcon = [];
  CategoryIcon shirtIconData;

  Future<void> getShirtIconData() async {
    List<CategoryIcon> newList = [];
    QuerySnapshot shirtIconSnapShot = await FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("dUeQcsaboB7shChdJXdo")
        .collection("shirt")
        .get();

    shirtIconSnapShot.docs.forEach(
      (element) {
        shirtIconData = CategoryIcon(
          image: element["image"],
        );
        newList.add(shirtIconData);
      },
    );
    shirtIcon = newList;
    notifyListeners();
  }

  List<CategoryIcon> get getshirtIconList {
    return shirtIcon;
  }

  //-------------------------------------------

  List<CategoryIcon> shoesIcon = [];
  CategoryIcon shoesIconData;

  Future<void> getShoesIconData() async {
    List<CategoryIcon> newList = [];
    QuerySnapshot shoesIconSnapShot = await FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("dUeQcsaboB7shChdJXdo")
        .collection("shoes")
        .get();

    shoesIconSnapShot.docs.forEach(
      (element) {
        shoesIconData = CategoryIcon(
          image: element["image"],
        );
        newList.add(shoesIconData);
      },
    );
    shoesIcon = newList;
    notifyListeners();
  }

  List<CategoryIcon> get getShoesIconList {
    return shoesIcon;
  }

  //--------------------------------------------

  List<CategoryIcon> tieIcon = [];
  CategoryIcon tieIconData;

  Future<void> getTieIconData() async {
    List<CategoryIcon> newList = [];
    QuerySnapshot tieIconSnapShot = await FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("dUeQcsaboB7shChdJXdo")
        .collection("tie")
        .get();

    tieIconSnapShot.docs.forEach(
      (element) {
        tieIconData = CategoryIcon(
          image: element["image"],
        );
        newList.add(tieIconData);
      },
    );
    tieIcon = newList;
    notifyListeners();
  }

  List<CategoryIcon> get getTieIconList {
    return tieIcon;
  }

  //-------------------------------------------

  List<CategoryIcon> pantIcon = [];
  CategoryIcon pantIconData;

  Future<void> getPantIconData() async {
    List<CategoryIcon> newList = [];
    QuerySnapshot pantIconSnapShot = await FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("dUeQcsaboB7shChdJXdo")
        .collection("pant")
        .get();

    pantIconSnapShot.docs.forEach(
      (element) {
        pantIconData = CategoryIcon(
          image: element["image"],
        );
        newList.add(pantIconData);
      },
    );
    pantIcon = newList;
    notifyListeners();
  }

  List<CategoryIcon> get getPantIconList {
    return pantIcon;
  }

  //--------------------------------------------

  /*==============================================================================

******************************Category**************************************
==============================================================================*/

  Future<void> getShirtData() async {
    List<Product> newList = [];
    QuerySnapshot shirtSnapShot = await FirebaseFirestore.instance
        .collection("category")
        .doc("PN20t3Ex4RIPzpzRzi8U")
        .collection("shirt")
        .get();

    shirtSnapShot.docs.forEach(
      (element) {
        shirtData = Product(
          image: element["image"],
          name: element["name"],
          price: element["price"],
        );
        newList.add(shirtData);
      },
    );
    shirt = newList;
    notifyListeners();
  }

  List<Product> get getShirtList {
    return shirt;
  }

  Future<void> getDressData() async {
    List<Product> newList = [];
    QuerySnapshot dressSnapShot = await FirebaseFirestore.instance
        .collection("category")
        .doc("PN20t3Ex4RIPzpzRzi8U")
        .collection("dress")
        .get();

    dressSnapShot.docs.forEach(
      (element) {
        dressData = Product(
          image: element["image"],
          name: element["name"],
          price: element["price"],
        );
        newList.add(dressData);
      },
    );
    dress = newList;
    notifyListeners();
  }

  List<Product> get getDressList {
    return dress;
  }

  Future<void> getPantData() async {
    List<Product> newList = [];
    QuerySnapshot pantSnapShot = await FirebaseFirestore.instance
        .collection("category")
        .doc("PN20t3Ex4RIPzpzRzi8U")
        .collection("pant")
        .get();

    pantSnapShot.docs.forEach(
      (element) {
        pantData = Product(
          image: element["image"],
          name: element["name"],
          price: element["price"],
        );
        newList.add(pantData);
      },
    );
    pant = newList;
    notifyListeners();
  }

  List<Product> get getPantList {
    return pant;
  }

  Future<void> getShoesData() async {
    List<Product> newList = [];
    QuerySnapshot shoesSnapShot = await FirebaseFirestore.instance
        .collection("category")
        .doc("PN20t3Ex4RIPzpzRzi8U")
        .collection("shoes")
        .get();

    shoesSnapShot.docs.forEach(
      (element) {
        shoesData = Product(
          image: element["image"],
          name: element["name"],
          price: element["price"],
        );
        newList.add(shoesData);
      },
    );
    shoes = newList;
    notifyListeners();
  }

  List<Product> get getShoesList {
    return shoes;
  }

  Future<void> getTieData() async {
    List<Product> newList = [];
    QuerySnapshot tieSnapShot = await FirebaseFirestore.instance
        .collection("category")
        .doc("PN20t3Ex4RIPzpzRzi8U")
        .collection("tie")
        .get();

    tieSnapShot.docs.forEach(
      (element) {
        tieData = Product(
          image: element["image"],
          name: element["name"],
          price: element["price"],
        );
        newList.add(tieData);
      },
    );
    tie = newList;
    notifyListeners();
  }

  List<Product> get getTieList {
    return tie;
  }
}
