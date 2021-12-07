import 'dart:io';
import 'package:chat_app/widget/send_message_field.dart';
import 'package:flutter/material.dart';

class PreviewImageScreen extends StatelessWidget {
  final String path;
  const PreviewImageScreen({Key? key, required this.path}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black,
        ),
        Center(
          child: Image.file(
            File(path),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent, //make appBar and status bar with transparent color
            elevation: 0,
          ),
          body: Align(
            alignment: Alignment.bottomCenter,
            child: SendMessageField(
              press: (){}, textEditingController:TextEditingController(),
              isPreview:true,
            ),
          ),
        ),
      ],
    );
  }
}
