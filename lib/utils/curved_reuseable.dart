import 'package:flutter/material.dart';

class SmoothBottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 105);

    path.cubicTo(
      size.width * 0.35, size.height - 50,
      size.width * 0.65, size.height - 50,
      size.width, size.height - 105,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}