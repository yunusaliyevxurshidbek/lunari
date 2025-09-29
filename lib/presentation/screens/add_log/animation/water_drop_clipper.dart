import 'package:flutter/material.dart';

class WaterDropClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.5, 0);
    path.quadraticBezierTo(
      size.width * 0.1,
      size.height * 0.3,
      size.width * 0.2,
      size.height * 0.75,
    );
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.95,
      size.width * 0.8,
      size.height * 0.75,
    );
    path.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.3,
      size.width * 0.5,
      0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
