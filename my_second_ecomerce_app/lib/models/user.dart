import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

// class UserServices {
//   FirebaseDatabase _database = FirebaseDatabase.instance;
//   String ref = "users";

//   createUser(String uid, Map value) {
//     _database
//         .reference()
//         .child("$ref/$uid")
//         .set(value)
//         .catchError((e) => {print(e.toString())});
//   }
// }
class UserServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = "userdad";

  void createUser(Map data) {
    _firestore
        .collection(collection)
        .doc(data["userId"])
        .set(data['name'], data["email"]);
  }
}
