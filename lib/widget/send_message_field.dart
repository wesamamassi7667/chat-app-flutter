import 'package:flutter/material.dart';

class SendMessageField extends StatelessWidget {
  const SendMessageField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 4, right: 4),
      child: Row(
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.2),
                        offset: Offset(0.0, 0.50),
                        spreadRadius: 1,
                        blurRadius: 1),
                  ]),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.insert_emoticon,
                    color: Colors.grey[500],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 60,
                      ),
                      child: Scrollbar(
                        child: TextField(
                          maxLines: null,
                          //null make keyboard data type is newline
                          style: TextStyle(fontSize: 14),
                          // controller: _textMessageController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message",
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.camera_alt),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          InkWell(
            onTap: () {
              // if (_textMessageController.text.isNotEmpty) {
              //   _sendTextMessage();
              // }
            },
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                // color: primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: Icon(
                Icons.send,
              ),
            ),
          )
        ],
      ),
    );
  }
}
