import 'package:flutter/material.dart';

import '../components/custom_shape.dart';
class Message extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.yellow
              ),
            ),
            child:  CustomPaint(painter: CustomShape(Colors.transparent)),
          )
      ),
    );
  }
}
