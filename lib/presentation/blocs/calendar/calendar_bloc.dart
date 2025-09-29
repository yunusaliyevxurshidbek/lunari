import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunari/presentation/blocs/calendar/calendar_event.dart';
import 'package:lunari/presentation/blocs/calendar/calendar_state.dart';
import '../../../core/services/log_service.dart';
import '../../../data/models/calendar_model.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot>? _logsSubscription;

  CalendarBloc() : super(CalendarState.initial()) {
    on<LoadLogs>(_onLoadLogs);
    on<SubscribeToLogs>(_onSubscribeToLogs);
    on<UpdateLogs>(_onUpdateLogs);
    on<DateSelected>(_onDateSelected);
    on<LoadUserData>(_onLoadUserData);
    on<UpdateUserData>(_onUpdateUserData);
  }

  Future<void> _onLoadUserData(
      LoadUserData event,
      Emitter<CalendarState> emit,
      ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    emit(state.copyWith(isLoading: true));

    String monthDocId(DateTime date) =>
        '${DateFormat('MMMM', 'en_US').format(date).toLowerCase()}-${date.year}';
    final currentDocId = monthDocId(state.currentMonth);
    final editColl = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('EditPeriod Calendar');
    final docSnap = await editColl.doc(currentDocId).get();

    if (docSnap.exists &&
        docSnap.data()!['selected_dates'] is List &&
        (docSnap.data()!['selected_dates'] as List).isNotEmpty) {
      final dates = (docSnap.get('selected_dates') as List)
          .cast<String>()
          .map((s) => DateTime.parse(s))
          .toList();
      final lastEdited = dates.reduce((a, b) => a.isAfter(b) ? a : b);

      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      final rawCycle = List<int>.from(userDoc.get('cycle') as List);
      int cycleLen;
      if (rawCycle.length == 1) {
        cycleLen = rawCycle.first;
      } else {
        final minVal = rawCycle.reduce(min);
        final maxVal = rawCycle.reduce(max);
        cycleLen = (maxVal - minVal == 2) ? minVal + 1 : minVal;
      }

      DateTime calcOv = lastEdited.add(Duration(days: (cycleLen / 2).floor()));
      final ovToShow = (calcOv.year == state.currentMonth.year &&
          calcOv.month == state.currentMonth.month)
          ? calcOv
          : null;

      emit(state.copyWith(
        editedDates: dates,
        ovulationDate: ovToShow,
        isLoading: false,
      ));
      return;
    }

    try {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      final data = userDoc.data() ?? {};

      DateTime? lastDate;
      int? periodDays;
      List<int> cycleDays = [];

      DateTime? initialOv;
      if (lastDate != null && periodDays != null && cycleDays.isNotEmpty) {
        final cycleLen = cycleDays.length == 1
            ? cycleDays.first
            : (() {
          final minVal = cycleDays.reduce(min);
          final maxVal = cycleDays.reduce(max);
          return (maxVal - minVal == 2) ? minVal + 1 : minVal;
        })();
        final firstCycleDay = lastDate.add(Duration(days: periodDays));
        initialOv = firstCycleDay.add(Duration(days: (cycleLen / 2).floor()));
      }
      final ovToShowInit = (initialOv != null &&
          initialOv.year == state.currentMonth.year &&
          initialOv.month == state.currentMonth.month)
          ? initialOv
          : null;

      emit(state.copyWith(
        last: lastDate,
        period: periodDays,
        cycle: cycleDays,
        ovulationDate: ovToShowInit,
        editedDates: const [],
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      LogService.e('Failed to load user data: $e');
    }
  }

  void _onUpdateUserData(UpdateUserData event, Emitter<CalendarState> emit) {
    emit(state.copyWith(
      last: event.last,
      period: event.period,
      cycle: event.cycle,
    ));
  }

  FutureOr<void> _onDateSelected(
      DateSelected event,
      Emitter<CalendarState> emit,
      ) {
    final newMonth = DateTime(event.date.year, event.date.month, 1);
    emit(state.copyWith(
      selectedDate: event.date,
      currentMonth: newMonth,
    ));
    add(LoadUserData());
    add((LoadLogs()));
  }

  void _onUpdateLogs(UpdateLogs event, Emitter<CalendarState> emit) {
    emit(state.copyWith(logs: event.logs));
  }

  Future<void> _onLoadLogs(LoadLogs event, Emitter<CalendarState> emit) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    emit(state.copyWith(isLoading: true));
    try {
      final firstOfMonth = DateTime(state.currentMonth.year, state.currentMonth.month, 1);
      final firstOfNextMonth = DateTime(
        state.currentMonth.year,
        state.currentMonth.month + 1,1);
      
      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('AddLog')
          .where("timestamp", isGreaterThanOrEqualTo: firstOfMonth)
          .where("timestamp",isLessThan: firstOfNextMonth)
          .orderBy('timestamp', descending: true)
          .get();

      final logs = snapshot.docs
          .map((doc) => CalendarEditModel.fromFirestore(doc.data(), doc.id))
          .toList();

      emit(state.copyWith(logs: logs, isLoading: false));
    } catch (e) {
      LogService.e('Failed to load logs: $e');
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onSubscribeToLogs(SubscribeToLogs event, Emitter<CalendarState> emit) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    _logsSubscription?.cancel();
    final firstOfMonth = DateTime(
        state.currentMonth.year,
        state.currentMonth.month, 1);
    final firstOfNextMonth = DateTime(
      state.currentMonth.year,
      state.currentMonth.month + 1,1);
    
    _logsSubscription = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('AddLog')
        .where("timestamp",isGreaterThanOrEqualTo: firstOfMonth)
        .where("timestamp",isLessThan: firstOfNextMonth)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      final logs = snapshot.docs
          .map((doc) => CalendarEditModel.fromFirestore(doc.data(), doc.id))
          .toList();
      add(UpdateLogs(logs));
    });
  }

  @override
  Future<void> close() {
    _logsSubscription?.cancel();
    return super.close();
  }
}