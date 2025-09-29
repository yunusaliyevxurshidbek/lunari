import 'package:flutter/material.dart';

class CircularProgressPainter extends CustomPainter {

  final int? selectedDaysCount;
  final int? totalDays;

  CircularProgressPainter({
     this.selectedDaysCount,
     this.totalDays,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = const Color(0xffEEEEEE)
      ..strokeWidth = 25
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint pinkProgressPaint = Paint()
      ..color = const Color(0xffFF699C)
      ..strokeWidth = 25
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint yellowProgressPaint = Paint()
      ..color = const Color(0xffFFC02D)
      ..strokeWidth = 25
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 25;

    canvas.drawCircle(center, radius, backgroundPaint);

    int adjustedSelectedDays = (selectedDaysCount == null || selectedDaysCount == 0) ? 1 : selectedDaysCount!;

    double value = (adjustedSelectedDays / totalDays!) * 3.14159;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -90 * 3.14159 / 180,
      value,
      false,
      pinkProgressPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      150 * 3.14159 / 180,
      (value + 11) / 180,
      false,
      yellowProgressPaint,
    );
  }
  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.selectedDaysCount != selectedDaysCount ||
        oldDelegate.totalDays != totalDays;
  }

}