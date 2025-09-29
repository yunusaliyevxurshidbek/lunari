import 'package:equatable/equatable.dart';

abstract class WaterEvent extends Equatable {
  const WaterEvent();
}

class LoadWaterData extends WaterEvent {
  const LoadWaterData();

  @override
  List<Object> get props => [];
}

class AddWater extends WaterEvent {
  final int amount;
  final String icon;

  const AddWater(this.amount, this.icon);

  @override
  List<Object> get props => [amount, icon];
}

class UpdateWaterFromAddLog extends WaterEvent {
  final int totalWater;
  final int lastConsumedWater;
  final String lastConsumedIcon;

  const UpdateWaterFromAddLog({
    required this.totalWater,
    required this.lastConsumedWater,
    required this.lastConsumedIcon,
  });

  @override
  List<Object> get props => [totalWater, lastConsumedWater, lastConsumedIcon];
}

