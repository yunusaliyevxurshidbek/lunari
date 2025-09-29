import 'dart:math';

import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final double value;
  final double totalConsumedWater; // Firestore'dan kelgan qiymat

  WavePainter({
    required this.value,
    required this.totalConsumedWater,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.blue.shade300.withOpacity(0.8),
          Colors.blue.shade600.withOpacity(0.9),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();

    // Animatsiya balandligini hisoblash
    final maxHeight = 2400.0; // Maksimal balandlik
    final waveHeight = 15.0; // To'lqin balandligi
    final consumedRatio = totalConsumedWater / maxHeight; // Nisbat
    final startHeight = size.height * (1 - consumedRatio); // Boshlanish balandligi

    path.moveTo(0, startHeight);

    final steps = 5;

    for (int i = 0; i <= steps; i++) {
      final x = size.width * (i / steps);
      final y = startHeight +
          sin((value * 2 * 3.14) + (i / steps) * 3.14) * waveHeight;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        final prevX = size.width * ((i - 1) / steps);
        final prevY = startHeight +
            sin((value * 2 * 3.14) + ((i - 1) / steps) * 3.14) * waveHeight;

        final midX = (prevX + x) / 2;
        path.quadraticBezierTo(midX, prevY, x, y);
      }
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final highlightPath = Path();
    highlightPath.moveTo(size.width * 0.3, startHeight);
    highlightPath.quadraticBezierTo(
      size.width * 0.5,
      startHeight - 5, // Biroz yuqoriga ko'tarish
      size.width * 0.7,
      startHeight,
    );
    highlightPath.quadraticBezierTo(
      size.width * 0.5,
      startHeight + 5, // Biroz pastga tushirish
      size.width * 0.3,
      startHeight,
    );

    canvas.drawPath(highlightPath, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}