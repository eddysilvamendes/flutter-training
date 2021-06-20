import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/model/cartmodel.dart';
import 'package:e_commerce_app/model/product.dart';
import 'package:e_commerce_app/model/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  Product newachivesData;
  List<Product> newachives = [];

//-------------User Provider-----------------------------

  UserModel userModel;
  List<UserModel> userModelList = [];

  Future<void> getUserData() async {
    List<UserModel> newList = [];
    User currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot userSnapShot =
        await FirebaseFirestore.instance.collection("User").get();

    userSnapShot.docs.forEach(
      (element) {
        if (currentUser.uid == element["UserId"]) {
          userModel = UserModel(
              userEmail: element["Email"],
              userGender: element["UserGender"],
              userName: element["UserName"],
              userPhoneNumber: element["Phone"],
              userAdress: element["Adress"],
              userImage: element["UserImage"]);
          newList.add(userModel);
        }
        userModelList = newList;
      },
    );
    notifyListeners();
  }

  List<UserModel> get getUserModelList {
    return userModelList;
  }

//----------------------------------------------------------------
  List<CartModel> checkOutModellList = [];
  CartModel checkOutModel;

  void getCheckOutData(
      {String name, String image, int quantity, double price}) {
    checkOutModel = CartModel(
      name: name,
      image: image,
      price: price,
      quantity: quantity,
    );
    checkOutModellList.add(checkOutModel);
  }

  List<CartModel> get getCheckOutModelList {
    return List.from(checkOutModellList);
  }

  int get getCheckOutModeListLength {
    return checkOutModellList.length;
  }

  //--------------------------------------------------------

  void deleteCartProduct(int index) {
    cartModelList.removeAt(index);
    notifyListeners();
  }

  void deleteCheckOutProduct(int index) {
    checkOutModellList.removeAt(index);
    notifyListeners();
  }

  void clearCheckOutProduct() {
    checkOutModellList.clear();
    notifyListeners();
  }

  List<CartModel> cartModelList = [];
  CartModel cartModel;

  void getCartData({String name, String image, int quantity, double price}) {
    cartModel = CartModel(
      name: name,
      image: image,
      price: price,
      quantity: quantity,
    );
    cartModelList.add(cartModel);
  }

  List<CartModel> get getCartModelList {
    return List.from(cartModelList);
  }

  int get getCartModelLength {
    return cartModelList.length;
  }

  Future<void> getNewAchivesData() async {
    List<Product> newList = [];
    QuerySnapshot newachivesSnapShot = await FirebaseFirestore.instance
        .collection("product")
        .doc("Cdzpw9smGeRQd2pJSPEF")
        .collection("newachives")
        .get();

    newachivesSnapShot.docs.forEach(
      (element) {
        newachivesData = Product(
          image: element["image"],
          name: element["name"],
          price: element["price"],
        );
        newList.add(newachivesData);
      },
    );
    newachives = newList;
    notifyListeners();
  }

  List<Product> get getNewAchivesList {
    return newachives;
  }

  Product featureData;
  List<Product> feature = [];
  Future<void> getFeatureData() async {
    List<Product> newList = [];
    QuerySnapshot featureSnapShot = await FirebaseFirestore.instance
        .collection("product")
        .doc("Cdzpw9smGeRQd2pJSPEF")
        .collection("feactureproduct")
        .get();

    featureSnapShot.docs.forEach(
      (element) {
        featureData = Product(
          image: element["image"],
          name: element["name"],
          price: element["price"],
        );
        newList.add(featureData);
      },
    );
    feature = newList;
    notifyListeners();
  }

  List<Product> get getFeatureList {
    return feature;
  }

  Product homefeatureData;
  List<Product> homefeature = [];
  Future<void> getHomeFeatureData() async {
    List<Product> newList = [];
    QuerySnapshot homefeatureSnapShot =
        await FirebaseFirestore.instance.collection("homefeature").get();

    homefeatureSnapShot.docs.forEach(
      (element) {
        homefeatureData = Product(
          image: element["image"],
          name: element["name"],
          price: element["price"],
        );
        newList.add(homefeatureData);
      },
    );
    homefeature = newList;
    notifyListeners();
  }

  List<Product> get getHomeFeatureList {
    return homefeature;
  }

  Product homeachiveData;
  List<Product> homeachive = [];

  Future<void> getHomeAchiveData() async {
    List<Product> newList = [];
    QuerySnapshot homeachiveSnapShot =
        await FirebaseFirestore.instance.collection("homeachive").get();

    homeachiveSnapShot.docs.forEach(
      (element) {
        homeachiveData = Product(
          image: element["image"],
          name: element["name"],
          price: element["price"],
        );
        newList.add(homeachiveData);
      },
    );
    homeachive = newList;
    notifyListeners();
  }

  List<Product> get getHomeAchiveList {
    return homeachive;
  }

  List<String> notificationList = [];

  void addNotification(String notification) {
    notificationList.add(notification);
  }

  int get getNotificationIndex {
    return notificationList.length;
  }
}
