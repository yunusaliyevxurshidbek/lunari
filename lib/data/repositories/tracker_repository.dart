import 'package:cloud_firestore/cloud_firestore.dart';


class TrackerRepository {
  final FirebaseFirestore _firestore;
  TrackerRepository({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<Map<String, dynamic>> fetchTrackerData(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (!doc.exists) throw Exception('User data not found');
    return doc.data()!;
  }
}

