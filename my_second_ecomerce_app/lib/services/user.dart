import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_second_ecomerce_app/models/cart_item.dart';
import 'package:my_second_ecomerce_app/models/userModel.dart';

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
  String collection = "user";

  void createUser(Map<String, dynamic> data) {
    _firestore.collection(collection).doc(data["uid"]).set(data);
  }

  Future<UserModel> getUserById(String id) =>
      _firestore.collection(collection).doc(id).get().then((doc) {
        return UserModel.fromSnapshot(doc);
      });

  void addToCart({required String userId, required CartItemModel cartItem}) {
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayUnion([cartItem.toMap()])
    });
  }

  void removeFromCart(
      {required String userId, required CartItemModel cartItem}) {
    _firestore.collection(collection).doc(userId).update({
      "cart": FieldValue.arrayRemove([cartItem.toMap()])
    });
  }

  Future<List<UserModel>> getusers() async =>
      _firestore.collection(collection).get().then((result) {
        List<UserModel> user = [];
        for (DocumentSnapshot product in result.docs) {
          user.add(UserModel.fromSnapshot(product));
        }
        return user;
      });
}
