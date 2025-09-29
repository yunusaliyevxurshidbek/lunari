import 'package:equatable/equatable.dart';

import '../../../data/models/log_entry.dart';

class WeekState extends Equatable {
  final DateTime selectedDate;
  final List<LogEntry> logs;
  final bool isLoading;
  final String? error;

  const WeekState({
    required this.selectedDate,
    this.logs = const [],
    this.isLoading = false,
    this.error,
  });

  DateTime get startOfWeek {
    final diff = selectedDate.weekday - 1;
    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day - diff,
    );
  }

  DateTime get endOfWeek => startOfWeek.add(const Duration(days: 6));

  WeekState copyWith({
    DateTime? selectedDate,
    List<LogEntry>? logs,
    bool? isLoading,
    String? error,
  }) {
    return WeekState(
      selectedDate: selectedDate ?? this.selectedDate,
      logs: logs ?? this.logs,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [selectedDate, logs, isLoading, error];
}