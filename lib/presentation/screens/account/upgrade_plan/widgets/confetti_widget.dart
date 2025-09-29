import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class ConfettiWidgetCustom extends StatefulWidget {
  const ConfettiWidgetCustom({super.key});

  @override
  _ConfettiWidgetCustomState createState() => _ConfettiWidgetCustomState();
}

class _ConfettiWidgetCustomState extends State<ConfettiWidgetCustom> {
  late ConfettiController _controllerLeft;
  late ConfettiController _controllerCenter;
  late ConfettiController _controllerRight;

  @override
  void initState() {
    super.initState();
    _controllerLeft = ConfettiController(duration: const Duration(seconds: 2));
    _controllerCenter = ConfettiController(duration: const Duration(seconds: 2));
    _controllerRight = ConfettiController(duration: const Duration(seconds: 2));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playConfetti();
    });
  }

  void _playConfetti() {
    _controllerLeft.play();
    Future.delayed(const Duration(milliseconds: 200), () => _controllerCenter.play());
    Future.delayed(const Duration(milliseconds: 400), () => _controllerRight.play());
  }

  @override
  void dispose() {
    _controllerLeft.dispose();
    _controllerCenter.dispose();
    _controllerRight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: ConfettiWidget(
            confettiController: _controllerLeft,
            blastDirectionality: BlastDirectionality.explosive,
            maxBlastForce: 5,
            minBlastForce: 2,
            emissionFrequency: 0.05,
            numberOfParticles: 10,
            gravity: 0.5,
            shouldLoop: false,
            colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _controllerCenter,
            blastDirectionality: BlastDirectionality.explosive,
            maxBlastForce: 5,
            minBlastForce: 2,
            emissionFrequency: 0.05,
            numberOfParticles: 10,
            gravity: 0.5,
            shouldLoop: false,
            colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: ConfettiWidget(
            confettiController: _controllerRight,
            blastDirectionality: BlastDirectionality.explosive,
            maxBlastForce: 5,
            minBlastForce: 2,
            emissionFrequency: 0.05,
            numberOfParticles: 10,
            gravity: 0.5,
            shouldLoop: false,
            colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
          ),
        ),
      ],
    );
  }
}
