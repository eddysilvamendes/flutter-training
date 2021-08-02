import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';


class DBService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createDB(String name, String dbName) {
    var id = Uuid();
    String categoryId = id.v1();
    _firestore.collection(dbName).doc(categoryId).set(
      {"name": name},
    );
  }

  String ref = 'category';

  void uploadCategory(Map<String, dynamic> data) {
    var id = Uuid();
    String productId = id.v1();
    data["uid"] = productId;
    _firestore.collection(ref).doc(productId).set(data);
  }
}
