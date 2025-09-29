import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PeriodTracker {
  static final PeriodTracker _instance = PeriodTracker._internal();
  factory PeriodTracker() => _instance;
  PeriodTracker._internal();

  List<DateTime> selectedDates = [];

  Stream<List<DateTime>> loadDates() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream.value([]); // Agar user yo‘q bo‘lsa, bo‘sh list qaytaramiz
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('tracker')
        .doc('EditPeriod Calendar')
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists || !snapshot.data()!.containsKey('selected_dates')) {
        return [];
      }

      List<String> dateStrings = (snapshot['selected_dates'] as List).cast<String>();
      return dateStrings.map((dateStr) => DateTime.parse(dateStr)).toList();
    });
  }

  void addDate(DateTime date) {
    if (!selectedDates.any((d) => _isSameDay(d, date))) {
      selectedDates.add(date);
    }
  }

  void removeDate(DateTime date) {
    selectedDates.removeWhere((d) => _isSameDay(d, date));
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}
