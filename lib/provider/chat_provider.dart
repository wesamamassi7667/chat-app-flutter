import 'package:cloud_firestore/cloud_firestore.dart';
class ChatProvider{
  final FirebaseFirestore firebaseFirestore;

  ChatProvider({required this.firebaseFirestore});


  Future<void> updateDataFirestore(
      String collectionPath, String path, Map<String, String> dataNeedUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(path) //current user id
        .update(dataNeedUpdate);
  }
}