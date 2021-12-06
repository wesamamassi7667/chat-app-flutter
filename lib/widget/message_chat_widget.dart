import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
class MessageChatWidget extends StatelessWidget {
  const MessageChatWidget({Key? key,required this.textMessage,  this.color,required this.time,
    this.crossAlign=CrossAxisAlignment.start, this.nip=BubbleNip.rightTop}) : super(key: key);
   final String textMessage,time;
   final Color? color;
   final CrossAxisAlignment crossAlign;
   final BubbleNip nip;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAlign,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.90,
          ),
          child: Bubble(
            margin: BubbleEdges.only(top: 10),
            color: color,
            nip: nip,
            child: Column(
              crossAxisAlignment:crossAlign,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$textMessage',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '$time',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(.4,),
                  ),
                )
              ],
            ),
          ),
        ),

      ],
    );
  }
}
