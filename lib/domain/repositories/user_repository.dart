import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lunari/core/services/log_service.dart';

import '../../data/models/firestore_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirestoreModel? _cachedUser;

  Future<FirestoreModel?> getUser(String userId) async {
    if (_cachedUser != null) return _cachedUser;

    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      LogService.i(doc.data().toString());
      _cachedUser = FirestoreModel.fromJson(doc.data()!);
      return _cachedUser;
    }
    return null;
  }
}
