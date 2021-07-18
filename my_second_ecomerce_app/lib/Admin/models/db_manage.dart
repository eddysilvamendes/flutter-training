import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class DBService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createDB(String name, String dbName) {
    var id = Uuid();
    String categoryId = id.v1();
    _firestore.collection(dbName).doc(categoryId).set(
      {"name": name},
    );
  }
}
