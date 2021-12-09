import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendMessageField extends StatelessWidget {
  const SendMessageField({Key? key, required this.textEditingController,required this.press,  this.pressCamera, this.isPreview=false})
      : super(key: key);
  final TextEditingController textEditingController;
  final VoidCallback press;
  final bool isPreview;
  final VoidCallback? pressCamera;


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
                 isPreview?SizedBox.shrink(): Icon(
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
                          enableInteractiveSelection: true,
                          maxLines: null, //null make keyboard data type is newline
                          controller: textEditingController,
                          style: TextStyle(fontSize: 14),
                          // controller: _textMessageController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            hintText: isPreview?"Add a caption...":"Type a message...",
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                 isPreview?SizedBox.shrink(): CupertinoButton(child: Icon(Icons.camera_alt,color: Colors.black87 ),onPressed: pressCamera,padding:EdgeInsets.zero,),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          CupertinoButton(child:  Icon(Icons.send,color: isPreview?Colors.white:Colors.black87,),onPressed: press,padding:EdgeInsets.zero,),
        ],
      ),
    );
  }
}
