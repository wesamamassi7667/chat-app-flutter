import 'package:chat_app/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key, required this.userId, required this.userAvatar, required this.userNickname}) : super(key: key);
  final String userId;
  final String userAvatar;
  final String userNickname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: userNickname,
      ),
      // body: StreamBuilder<QuerySnapshot>(
      //
      // )
    );
  }
}


