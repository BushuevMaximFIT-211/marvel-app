import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  Color colorShape = Color.fromARGB(255, 98, 0, 0);
  BackgroundPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, size.width, size.height));
    paint.color = Colors.grey.shade900;
    canvas.drawPath(mainBackground, paint);
    final trianglePath = Path();

    trianglePath.moveTo(size.width, size.height);
    trianglePath.lineTo(size.width, size.width / 2);
    trianglePath.lineTo(0, size.height);
    paint.color = colorShape;
    canvas.drawPath(trianglePath, paint);
  }

  void setColor(Color colorShape) {
    colorShape = colorShape;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
