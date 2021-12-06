import 'package:cloud_firestore/cloud_firestore.dart';

class MessageChat {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  int type;


  MessageChat(this.idFrom, this.idTo, this.timestamp, this.content, this.type);

  Map<String, dynamic> toJson() {
    return {
      "idFrom": this.idFrom,
      "idTo": this.idTo,
      "timestamp": this.timestamp,
      "content": this.content,
      "type": this.type,
    };
  }

  factory MessageChat.fromDocument(DocumentSnapshot document) {
    return MessageChat(
      document["idFrom"] as String,
      document["idTo"] as String,
      document["timestamp"] as String,
      document["content"] as String,
      document["type"] as int,

    );
  }
}
