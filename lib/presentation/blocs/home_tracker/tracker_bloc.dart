import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunari/presentation/blocs/home_tracker/tracker_event.dart';
import 'package:lunari/presentation/blocs/home_tracker/tracker_state.dart';
import '../../../data/repositories/tracker_repository.dart';

class TrackerBloc extends Bloc<TrackerEvent, TrackerState> {
  final TrackerRepository repository;
  TrackerBloc({required this.repository}) : super(TrackerState.initial()) {
    on<LoadTrackerData>(_onLoad);
  }

  Future<void> _onLoad(LoadTrackerData event, Emitter<TrackerState> emit) async {
    emit(state.copyWith(isLoaded: false, error: null));

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not logged in');

      final data = await repository.fetchTrackerData(user.uid);

      final cycleField = data['cycle'];
      int cycleDays;
      if (cycleField is int) {
        cycleDays = cycleField;
      } else if (cycleField is List) {
        final list = List<int>.from(cycleField);
        final minVal = list.reduce((a, b) => a < b ? a : b);
        final maxVal = list.reduce((a, b) => a > b ? a : b);
        cycleDays = (maxVal - minVal == 2) ? minVal + 1 : minVal;
      } else {
        cycleDays = 28;
      }

      final lastList = data['last'] as List<dynamic>? ?? [];
      if (lastList.isEmpty) throw Exception('No last-period dates found');
      final lastStr = lastList.last as String;
      final lastDay = DateFormat('dd.MM.yyyy').parse(lastStr);

      final periodLen = (data['period'] as int? ?? 4);

      final periodDates = List<DateTime>.generate(
        periodLen,
            (i) => lastDay.add(Duration(days: i)),
      );

      final today = DateTime.now();

      final isInPeriod = periodDates.any((d) => _isSameDay(d, today));

      final firstCycleDay = lastDay.add(Duration(days: periodLen));

      int currentDayNumber;
      int totalDaysForContext;

      if (isInPeriod) {
        currentDayNumber = today.difference(lastDay).inDays + 1;
        totalDaysForContext = periodLen;
      } else if (!today.isBefore(firstCycleDay)) {
        currentDayNumber = today.difference(firstCycleDay).inDays + 1;
        totalDaysForContext = cycleDays;
      } else {
        currentDayNumber = 0;
        totalDaysForContext = cycleDays;
      }

      final ovulationDate = firstCycleDay.add(Duration(days: (cycleDays / 2).floor()));
      final ovulationDaysLeft = ovulationDate.isAfter(today)
          ? ovulationDate.difference(today).inDays
          : 0;

      emit(state.copyWith(
        currentDayNumber: currentDayNumber,
        totalDaysForContext: totalDaysForContext,
        isInPeriod: isInPeriod,
        ovulationDaysLeft: ovulationDaysLeft,
        isLoaded: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoaded: true,
        error: e.toString(),
      ));
    }
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}

