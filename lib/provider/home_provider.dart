import 'package:cloud_firestore/cloud_firestore.dart';

class HomeProvider {
  final FirebaseFirestore firebaseFirestore;

  HomeProvider({required this.firebaseFirestore});


  Future<void> updateDataFirestore(
      String collectionPath, String path, Map<String, String> dataNeedUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(path) //current user id
        .update(dataNeedUpdate);
  }

  Stream<QuerySnapshot> getAccountStream(String collection, int limit,
      {required String searchText}) {
    print("home");

    if (searchText.isNotEmpty) {
      return firebaseFirestore
          .collection(collection)
          .where('displayName', isGreaterThanOrEqualTo: searchText.trim())
          .where('displayName', isLessThan: searchText.trim() + 'z')
          .limit(limit)
          .snapshots();
    }

    return firebaseFirestore.collection(collection).limit(limit).snapshots();
  }
}
