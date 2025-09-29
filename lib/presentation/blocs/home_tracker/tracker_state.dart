import 'package:equatable/equatable.dart';

class TrackerState extends Equatable {
  final int currentDayNumber;
  final int totalDaysForContext;
  final bool isInPeriod;
  final int ovulationDaysLeft;
  final bool isLoaded;
  final String? error;

  const TrackerState({
    required this.currentDayNumber,
    required this.totalDaysForContext,
    required this.isInPeriod,
    required this.ovulationDaysLeft,
    required this.isLoaded,
    this.error,
  });

  factory TrackerState.initial() => const TrackerState(
    currentDayNumber: 0,
    totalDaysForContext: 0,
    isInPeriod: false,
    ovulationDaysLeft: 0,
    isLoaded: false,
  );

  TrackerState copyWith({
    int? currentDayNumber,
    int? totalDaysForContext,
    bool? isInPeriod,
    int? ovulationDaysLeft,
    bool? isLoaded,
    String? error,
  }) {
    return TrackerState(
      currentDayNumber: currentDayNumber ?? this.currentDayNumber,
      totalDaysForContext: totalDaysForContext ?? this.totalDaysForContext,
      isInPeriod: isInPeriod ?? this.isInPeriod,
      ovulationDaysLeft: ovulationDaysLeft ?? this.ovulationDaysLeft,
      isLoaded: isLoaded ?? this.isLoaded,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    currentDayNumber,
    totalDaysForContext,
    isInPeriod,
    ovulationDaysLeft,
    isLoaded,
    error,
  ];
}


