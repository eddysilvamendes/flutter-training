import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  static const String NAME = 'name';
  static const String IMAGE = 'picture';

  //  private variables
  late String _name;
  late String _image;

//  getters
  String get name => _name;
  String get image => _image;

  CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot[NAME];
    _image = snapshot[IMAGE];
  }
}
