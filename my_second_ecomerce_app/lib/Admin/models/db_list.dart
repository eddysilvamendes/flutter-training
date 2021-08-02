import 'package:cloud_firestore/cloud_firestore.dart';

class DBList {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> getCategoryList() {
    return _firestore.collection("category").get().then((snap) {
      return snap.docs;
    });
  }

  Future<List<DocumentSnapshot>> getBrandList() =>
      _firestore.collection("brand").get().then((snap) {
        return snap.docs;
      });

  Future<List<DocumentSnapshot>> getSuggestion(String suggestion) => _firestore
          .collection("category")
          .where("category", isEqualTo: suggestion)
          .get()
          .then((snap) {
        return snap.docs;
      });
}
