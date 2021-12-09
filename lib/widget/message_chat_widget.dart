import 'package:chat_app/components/custom_shape.dart';
import 'package:flutter/material.dart';
class MessageChatWidget extends StatelessWidget {
  const MessageChatWidget({Key? key,required this.textMessage, required this.color,required this.time,
    this.crossAlign=CrossAxisAlignment.start}) : super(key: key);
   final String textMessage,time;
   final Color color;
   final CrossAxisAlignment crossAlign;


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.90,
                  ),
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textMessage,
                          style: TextStyle( fontSize: 14),
                        ),
                        SizedBox(height: 5,),
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

              CustomPaint(painter: CustomShape(color)),
            ],
          ),
    );
        // ConstrainedBox(
        //   constraints: BoxConstraints(
        //     maxWidth: MediaQuery.of(context).size.width * 0.90,
        //   ),
        //   child:Flexible(
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //
        //       children: [
        //
        //         Flexible(
        //           child: Container(
        //             margin: EdgeInsets.only(top: 10),
        //             padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
        //
        //             decoration: BoxDecoration(
        //               color: color,
        //               borderRadius: BorderRadius.only(
        //                 topLeft: Radius.circular(18),
        //                 bottomLeft: Radius.circular(18),
        //                 bottomRight: Radius.circular(18),
        //               ),
        //             ),
        //             child: Column(
        //               children: [
        //                 Text(
        //                   textMessage,
        //                   style: TextStyle(fontSize: 14),
        //                 ),
        //                 SizedBox(height: 5,),
        //                 Text(
        //                   '$time',
        //                   style: TextStyle(
        //                     fontSize: 12,
        //                     color: Colors.black.withOpacity(.4,),
        //                   ),
        //                 )
        //               ],
        //             ),
        //           ),
        //         ),
        //         CustomPaint(painter: CustomShape(color),),
        //
        //       ],
        //     ),
        //   ) ,
        // );
  }
}
