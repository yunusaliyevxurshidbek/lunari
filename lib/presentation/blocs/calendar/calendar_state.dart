import 'package:lunari/data/models/calendar_model.dart';

class CalendarState {
  final List<CalendarEditModel> logs;
  final bool isLoading;
  final DateTime currentMonth;
  final DateTime selectedDate;
  final DateTime? last;
  final int? period;
  final List<int> cycle;
  final DateTime? ovulationDate;
  final List<DateTime> editedDates;


  CalendarState({
    required this.logs,
    required this.isLoading,
    required this.currentMonth,
    required this.selectedDate,
    this.last,
    this.period,
    this.cycle = const [],
    this.ovulationDate,
    this.editedDates = const [],
  });

  factory CalendarState.initial() {
    final now = DateTime.now();
    return CalendarState(
      logs: const [],
      isLoading: false,
      currentMonth: DateTime(now.year, now.month, 1),
      selectedDate: now,
      last: null,
      period: null,
      cycle: const [],
      ovulationDate: now,
      editedDates: const [],
    );
  }

  CalendarState copyWith({
    List<CalendarEditModel>? logs,
    bool? isLoading,
    DateTime? currentMonth,
    DateTime? selectedDate,
    DateTime? last,
    int? period,
    List<int>? cycle,
    DateTime? ovulationDate,
    List<DateTime>? editedDates,
  }) {
    return CalendarState(
      logs: logs ?? this.logs,
      isLoading: isLoading ?? this.isLoading,
      currentMonth: currentMonth ?? this.currentMonth,
      selectedDate: selectedDate ?? this.selectedDate,
      last: last ?? this.last,
      period: period ?? this.period,
      cycle: cycle ?? this.cycle,
      ovulationDate: ovulationDate ?? this.ovulationDate,
      editedDates: editedDates ?? this.editedDates,
    );
  }
}
