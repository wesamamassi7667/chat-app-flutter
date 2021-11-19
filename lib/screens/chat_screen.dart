import 'package:chat_app/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(

      ),
      body: ListView.builder(
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
    );
  }
}


