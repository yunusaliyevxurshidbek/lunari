
import '../../models/individual_bar.dart';

class BarData {
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;
  final double sunAmount;

  BarData({
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
    required this.sunAmount,
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    barData = [
      IndividualBar(x: startOfWeek.day, y: monAmount),
      IndividualBar(x: startOfWeek.add(const Duration(days: 1)).day, y: tueAmount),
      IndividualBar(x: startOfWeek.add(const Duration(days: 2)).day, y: wedAmount),
      IndividualBar(x: startOfWeek.add(const Duration(days: 3)).day, y: thurAmount),
      IndividualBar(x: startOfWeek.add(const Duration(days: 4)).day, y: friAmount),
      IndividualBar(x: startOfWeek.add(const Duration(days: 5)).day, y: satAmount),
      IndividualBar(x: startOfWeek.add(const Duration(days: 6)).day, y: sunAmount),
    ];
  }

}
