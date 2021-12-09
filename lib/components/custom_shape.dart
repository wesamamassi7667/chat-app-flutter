
import 'package:flutter/material.dart';

class CustomShape extends CustomPainter {
  final Color bgColor;

  CustomShape( this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {

    var paint1 = Paint()..style = PaintingStyle.stroke
      ..strokeWidth=1.0;

    //for example
    var path = Path();
    path.lineTo( 100, 0);
    path.lineTo(0, 50);
    path.lineTo(50, 100);
    // canvas.drawPath(path, paint1);

    //for chat message
    var paint = Paint()..color = bgColor;
    var path1 = Path();
    path1.lineTo(-5, 0);
    path1.lineTo(0, 10);
    path1.lineTo(5,0);
    canvas.drawPath(path1, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}