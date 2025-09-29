import 'package:equatable/equatable.dart';

class WaterState extends Equatable {
  final int totalWaterConsumed;
  final int lastConsumedWater;
  final String lastConsumedIcon;

  const WaterState({
    this.totalWaterConsumed = 0,
    this.lastConsumedWater = 0,
    this.lastConsumedIcon = 'assets/images/100ml.png',
  });

  WaterState copyWith({
    int? totalWaterConsumed,
    int? lastConsumedWater,
    String? lastConsumedIcon,
  }) {
    return WaterState(
      totalWaterConsumed: totalWaterConsumed ?? this.totalWaterConsumed,
      lastConsumedWater: lastConsumedWater ?? this.lastConsumedWater,
      lastConsumedIcon: lastConsumedIcon ?? this.lastConsumedIcon,
    );
  }

  @override
  List<Object> get props => [totalWaterConsumed, lastConsumedWater, lastConsumedIcon];
}