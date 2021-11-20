import 'package:cloud_firestore/cloud_firestore.dart';

class HomeProvider{
final FirebaseFirestore firebaseFirestore;

  HomeProvider({required this.firebaseFirestore});

   Stream<QuerySnapshot> getAccountStream(String collection,int limit,{required String searchText}){
    if(searchText.isNotEmpty){
      print("home");
     return firebaseFirestore.collection(collection).where(
        "displayName",isEqualTo: searchText
      ).limit(limit).snapshots();
    }

    return firebaseFirestore.collection(collection).limit(limit).snapshots();
  }

}