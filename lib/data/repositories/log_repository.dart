import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../models/log_entry.dart';

class LogRepository {
  final FirebaseFirestore _firestore;

  LogRepository([FirebaseFirestore? instance])
      : _firestore = instance ?? FirebaseFirestore.instance;

  Future<List<LogEntry>> fetchLogsForWeek({
    required String uid,
    required DateTime startOfWeek,
    required DateTime endOfWeek,
  }) async {
    try {
      final startKey = DateFormat('yyyy-MM-dd').format(startOfWeek);
      final endKey = DateFormat('yyyy-MM-dd').format(endOfWeek);


      final query = _firestore
          .collection('users')
          .doc(uid)
          .collection('AddLog')
          .where(FieldPath.documentId, isGreaterThanOrEqualTo: startKey)
          .where(FieldPath.documentId, isLessThanOrEqualTo: endKey);

      final snapshot = await query.get();


      return snapshot.docs
          .map((doc) {
        return LogEntry.fromFirestore(doc);
      })
          .toList();
    } catch (e) {
      print(" Error fetching logs: $e");
      rethrow;
    }
  }
}
