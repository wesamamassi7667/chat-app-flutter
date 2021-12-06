import 'package:chat_app/components/app_bar.dart';
import 'package:chat_app/constant.dart';
import 'package:chat_app/provider/auth_model.dart';
import 'package:chat_app/provider/chat_provider.dart';
import 'package:chat_app/widget/send_message_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bubble/bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {Key? key,
      required this.userId,
      required this.userAvatar,
      required this.userNickname})
      : super(key: key);
  final String userId;
  final String userAvatar;
  final String userNickname;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String currentUserId, chatId;

  @override
  void initState() {
    // TODO: implement initState
    AuthProvider _authProvider = context.read<AuthProvider>();
    ChatProvider _chatProvider = context.read<ChatProvider>();
    currentUserId = _authProvider.getUserFirebaseId();
    if (currentUserId.compareTo(widget.userId) > 0) {
      chatId = '$currentUserId-${widget.userId}';
    } else {
      chatId = '${widget.userId}-$currentUserId';
    }
    _chatProvider.updateDataFirestore(userCollection, currentUserId,{"chattingWith":chatId});


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: widget.userNickname,
      ),
      body:Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: 10,
              padding: EdgeInsets.all(15),
              itemBuilder: (context,index){
                return Bubble(
                  margin: BubbleEdges.only(top: 10),
                  stick: true, //false min width
                  nip: BubbleNip.rightTop,
                  color: index.isOdd?Color.fromRGBO(212, 234, 244, 1.0):null,
                  child: Text('Hello, World!', textAlign: TextAlign.start),
                );
              },
            ),
          ),
          SendMessageField()




        ],
      )
    );
  }
}
