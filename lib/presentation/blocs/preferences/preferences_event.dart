import 'package:equatable/equatable.dart';

abstract class PreferencesEvent extends Equatable {
  const PreferencesEvent();
  @override
  List<Object?> get props => [];
}

class LoadPreferences extends PreferencesEvent {}

class WeightUnitChanged extends PreferencesEvent {
  final String value;
  const WeightUnitChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class HeightUnitChanged extends PreferencesEvent {
  final String value;
  const HeightUnitChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class TemperatureUnitChanged extends PreferencesEvent {
  final String value;
  const TemperatureUnitChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class WaterGoalChanged extends PreferencesEvent {
  final String value;
  const WaterGoalChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class CupUnitChanged extends PreferencesEvent {
  final String value;
  const CupUnitChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class FirstDayChanged extends PreferencesEvent {
  final String value;
  const FirstDayChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class TimeFormatChanged extends PreferencesEvent {
  final String value;
  const TimeFormatChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class BmiToggled extends PreferencesEvent {
  final bool value;
  const BmiToggled(this.value);
  @override
  List<Object?> get props => [value];
}

class DayResetTimeChanged extends PreferencesEvent {
  final int value; // minutes since midnight
  const DayResetTimeChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class CacheSizeCalculated extends PreferencesEvent {
  final double sizeMB;
  CacheSizeCalculated(this.sizeMB);
}