import 'package:cloud_firestore/cloud_firestore.dart';
class UserChat {
  String id;
  String photoUrl;
  String displayName;
  String aboutMe;

  UserChat(this.id, this.photoUrl, this.displayName, this.aboutMe);
  factory UserChat.fromDocument(DocumentSnapshot document) => UserChat(
        document["id"] as String,
        document["photoUrl"] as String,
        document["displayName"] as String,
        document["AboutMe"] as String,
      );
    Map<String,dynamic> $UserToDocument(UserChat userChat)=>
       <String,dynamic> {
          "id":userChat.id,
           "photoUrl":userChat.photoUrl,
           "nickname": userChat.displayName,
           "AboutMe":userChat.aboutMe
        };
}
