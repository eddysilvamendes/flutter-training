import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const String BRAND = 'brand';
  static const String CATEGORY = 'category';
  static const String COLORS = 'colors';
  static const String FEATURED = 'featured';
  static const String UID = 'uid';
  static const String NAME = 'name';
  static const String PICTURE = 'picture';
  static const String PRICE = 'price';
  static const String QUANTITY = 'quantity';
  static const String SALE = 'sale';
  static const String SIZE = 'sizes';

  //  private variables
  late String _brand;
  late String _category;
  late String _uid;
  late String _name;
  late String _picture;
  late double _price;
  late int _quantity;
  late List _colors;
  late List _size;
  late bool _featured;
  late bool _sale;

//  getters
  String get brand => _brand;
  String get category => _category;
  String get id => _uid;
  String get name => _name;
  String get picture => _picture;
  double get price => _price;
  int get quantity => _quantity;
  List get colors => _colors;
  List get size => _size;
  bool get featured => _featured;
  bool get sale => _sale;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _featured = snapshot[FEATURED];
    _brand = snapshot[BRAND];
    _category = snapshot[CATEGORY];
    _uid = snapshot[UID];
    _name = snapshot[NAME];
    _picture = snapshot[PICTURE];
    _price = snapshot[PRICE];
    _colors = snapshot[COLORS];
    _size = snapshot[SIZE];
    _sale = snapshot[SALE];
    _quantity = snapshot[QUANTITY];
  }
}
