import 'package:chat_app/constant.dart';
import 'package:chat_app/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatProvider {
  final FirebaseFirestore firebaseFirestore;

  ChatProvider({required this.firebaseFirestore});

  Future<void> updateDataFirestore(
      String collectionPath, String path, Map<String, String> dataNeedUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(path) //current user id
        .update(dataNeedUpdate);
  }

  void sendMessage(String content, int type, String groupChatId,
      String currentUserId, String peerId) {
    DocumentReference documentReference = firebaseFirestore
        .collection(messageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    MessageChat messageChat = MessageChat(
      currentUserId,
      peerId,
      DateTime.now().millisecondsSinceEpoch.toString(),
      content,
      type,
    );

    //timer for 30 seconds
    firebaseFirestore.runTransaction((transaction) async {
      // write message chat to document reference if exist,
      // if not exist create doc and write message chat to document
      transaction.set(
        documentReference,
        messageChat.toJson(),
      );
    });
  }


  Stream<QuerySnapshot> getChatStream(String groupChatId, int limit) {
    return firebaseFirestore
        .collection(messageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy("timestamp", descending: true)
        .limit(limit)
        .snapshots();
  }
}
