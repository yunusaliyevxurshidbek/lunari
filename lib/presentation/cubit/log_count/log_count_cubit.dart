import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/log_count_model.dart';
import 'log_count_state.dart';

class LogCountCubit extends Cubit<LogCountState> {
  final FirebaseFirestore _firestore;

  LogCountCubit(this._firestore) : super(LogCountInitial());

  String get _userId {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw StateError('User is not logged in');
    return user.uid;
  }

  Future<void> fetchAllCounts() async {
    emit(LogCountLoading());
    try {
      final coll = _firestore.collection('users').doc(_userId).collection('AddLog');
      final snapshot = await coll.get();

      for (var doc in snapshot.docs) {
      }

      if (snapshot.docs.isEmpty) {
        final todayId = DateTime.now().toIso8601String().split('T').first;
        final defaultEntry = LogCountEntry(date: DateTime.parse(todayId));
        emit(LogCountLoaded([defaultEntry]));
      } else {
        final entries = snapshot.docs
            .map((doc) => LogCountEntry.fromDoc(doc))
            .toList()
          ..sort((a, b) => a.date.compareTo(b.date));
        emit(LogCountLoaded(entries));
      }
    } catch (e) {
      emit(LogCountError(e.toString()));
    }
  }
  Future<void> fetchCountByDate(String dateId) async {
    emit(LogCountLoading());

    try {
      final docRef = _firestore.collection('users').doc(_userId).collection('AddLog').doc(dateId);
      final doc = await docRef.get();

      if (!doc.exists) {
        final defaultEntry = LogCountEntry(date: DateTime.parse(dateId));
        emit(LogCountLoaded([defaultEntry]));
      } else {
        final entry = LogCountEntry.fromDoc(doc);
        emit(LogCountLoaded([entry]));
      }
    } catch (e) {
      emit(LogCountError(e.toString()));
    }
  }
}

