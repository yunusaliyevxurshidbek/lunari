import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'edit_period_event.dart';
part 'edit_period_state.dart';

class EditPeriodBloc extends Bloc<EditPeriodEvent, EditPeriodState> {
  EditPeriodBloc() : super(EditPeriodInitial()) {
    on<LoadSelectedDates>(_onLoadSelectedDates);
    on<ToggleDateSelection>(_onToggleDateSelection);
    on<SaveSelectedDates>(_onSaveSelectedDates);
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Map<String, List<DateTime>> selectedDatesByMonth = {};

  String _monthDocId(DateTime date) {
    final monthName = DateFormat('MMMM', 'en_US').format(date).toLowerCase();
    return '$monthName-${date.year}';
  }

  Future<void> _onLoadSelectedDates(
      LoadSelectedDates event,
      Emitter<EditPeriodState> emit,
      ) async {
    emit(EditPeriodLoading());
    try {
      final user = _auth.currentUser;
      if (user == null) throw 'User not logged in!';

      final coll = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('EditPeriod Calendar');
      final snapshot = await coll.get();

      selectedDatesByMonth.clear();
      for (final doc in snapshot.docs) {
        final id = doc.id; // e.g. 'june-2025'
        final data = doc.data();
        if (data.containsKey('selected_dates')) {
          final dateStrings = List<String>.from(data['selected_dates']);
          selectedDatesByMonth[id] = dateStrings
              .map((s) => DateTime.parse(s))
              .toList();
        } else {
          selectedDatesByMonth[id] = [];
        }
      }

      final months = [
        DateTime.now(),
        DateTime.now().subtract(const Duration(days: 30)),
      ];
      for (final month in months) {
        final key = _monthDocId(month);
        if (!selectedDatesByMonth.containsKey(key)) {
          selectedDatesByMonth[key] = [];
          await coll.doc(key).set({'selected_dates': []});
        }
      }

      final allSelected = selectedDatesByMonth.values.expand((e) => e).toList();
      emit(EditPeriodLoaded(allSelected));
    } catch (e) {
      emit(EditPeriodError('Error loading dates: $e'));
    }
  }

  void _onToggleDateSelection(
      ToggleDateSelection event,
      Emitter<EditPeriodState> emit,
      ) {
    final date = event.date;
    if (date.isAfter(DateTime.now())) {
      emit(EditPeriodError("Only past dates can be selected!"));
      return;
    }

    final docId = _monthDocId(date);
    final list = selectedDatesByMonth.putIfAbsent(docId, () => []);

    final exists = list.any((d) => _isSameDay(d, date));
    if (exists) {
      list.removeWhere((d) => _isSameDay(d, date));
    } else {
      list.add(date);
    }

    final allSelected = selectedDatesByMonth.values.expand((e) => e).toList();
    emit(EditPeriodLoaded(allSelected));
  }

  Future<void> _onSaveSelectedDates(
      SaveSelectedDates event,
      Emitter<EditPeriodState> emit,
      ) async {
    final totalCount = selectedDatesByMonth.values
        .fold<int>(0, (sum, list) => sum + list.length);
    if (totalCount == 0) {
      emit(EditPeriodError("Please select at least one date!"));
      return;
    }

    emit(EditPeriodLoading());
    try {
      final user = _auth.currentUser;
      if (user == null) throw 'User not logged in!';

      final coll = _firestore
          .collection('users')
          .doc(user.uid)
          .collection('EditPeriod Calendar');

      for (final entry in selectedDatesByMonth.entries) {
        final docId = entry.key;
        final dates = entry.value;
        final dateStrings = dates.map((d) => d.toIso8601String()).toList();

        await coll.doc(docId).set({'selected_dates': dateStrings},
            SetOptions(merge: true));
      }

      emit(EditPeriodSaved());
    } catch (e) {
      emit(EditPeriodError('Error saving dates: $e'));
    }
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}
