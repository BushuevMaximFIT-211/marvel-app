import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  final int indexColor;
  final List<Color> colorList = const [
    Color.fromARGB(255, 73, 167, 180),
    Color.fromARGB(255, 25, 138, 74),
    Color.fromARGB(255, 189, 194, 61),
    Color.fromARGB(255, 106, 33, 162),
    Color.fromARGB(255, 36, 90, 185)
  ];
  Color paintColor;
  BackgroundPainter(this.indexColor, this.paintColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, size.width, size.height));
    paint.color = paintColor;
    canvas.drawPath(mainBackground, paint);
    final trianglePath = Path();

    trianglePath.moveTo(size.width, size.height);
    trianglePath.lineTo(size.width, size.width / 2);
    trianglePath.lineTo(0, size.height);
    paint.color = colorList[indexColor];
    canvas.drawPath(trianglePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
