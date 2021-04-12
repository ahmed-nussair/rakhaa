import 'package:flutter/material.dart';

class Ribbon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width / 2, 0);
    path.lineTo(0, 0);
    path.close();
    canvas.drawPath(path, Paint()..color = Colors.red);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw false;
  }
}
