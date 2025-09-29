import 'package:equatable/equatable.dart';

class PreferencesState extends Equatable {
  final String weightUnit;
  final String heightUnit;
  final String temperatureUnit;
  final String waterGoal;
  final String cupUnit;
  final String firstDay;
  final String timeFormat;
  final bool isBmiEnabled;
  final int dayResetTimeInMinutes;
  final double cacheSizeMB;

  const PreferencesState({
    this.weightUnit = 'kg',
    this.heightUnit = 'cm',
    this.temperatureUnit = '°C',
    this.waterGoal = '2400',
    this.cupUnit = 'mL',
    this.firstDay = 'Sunday',
    this.timeFormat = 'System Default',
    this.isBmiEnabled = true,
    this.dayResetTimeInMinutes = 0,
    this.cacheSizeMB = 0
  });

  PreferencesState copyWith({
    String? weightUnit,
    String? heightUnit,
    String? temperatureUnit,
    String? waterGoal,
    String? cupUnit,
    String? firstDay,
    String? timeFormat,
    bool? isBmiEnabled,
    int? dayResetTimeInMinutes,
    double? cacheSizeMB,
  }) {
    return PreferencesState(
      weightUnit: weightUnit ?? this.weightUnit,
      heightUnit: heightUnit ?? this.heightUnit,
      temperatureUnit: temperatureUnit ?? this.temperatureUnit,
      waterGoal: waterGoal ?? this.waterGoal,
      cupUnit: cupUnit ?? this.cupUnit,
      firstDay: firstDay ?? this.firstDay,
      timeFormat: timeFormat ?? this.timeFormat,
      isBmiEnabled: isBmiEnabled ?? this.isBmiEnabled,
      dayResetTimeInMinutes: dayResetTimeInMinutes ?? this.dayResetTimeInMinutes,
      cacheSizeMB: cacheSizeMB ?? this.cacheSizeMB,
    );
  }

  @override
  List<Object?> get props => [
    weightUnit,
    heightUnit,
    temperatureUnit,
    waterGoal,
    cupUnit,
    firstDay,
    timeFormat,
    isBmiEnabled,
    dayResetTimeInMinutes,
    cacheSizeMB,
  ];
}
