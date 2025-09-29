import 'package:flutter/material.dart';
import 'package:lunari/presentation/screens/add_log/animation/wave_painter.dart';

class WaveAnimation extends StatefulWidget {
  final double totalConsumedWater;

  const WaveAnimation({Key? key,  required this.totalConsumedWater}) : super(key: key);

  @override
  _WaveAnimationState createState() => _WaveAnimationState();
}

class _WaveAnimationState extends State<WaveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(100, 100),
          painter: WavePainter(
            value: _controller.value,
            totalConsumedWater: widget.totalConsumedWater,
          ),
        );
      },
    );
  }
}

