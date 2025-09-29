import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SetUpDates {
  final String name;
  final DateTime birthday;
  final double weight;
  final double height;
  final String period;
  final dynamic cycle;
  final DateTime last;

  SetUpDates({
    required this.name,
    required this.birthday,
    required this.weight,
    required this.height,
    required this.period,
    required this.cycle,
    required this.last,
  });

  factory SetUpDates.fromFirestore(Map<String, dynamic> data) {
    return SetUpDates(
      name: data['name'] ?? '',
      birthday: (data['birthday'] as Timestamp).toDate(),
      weight: (data['weight'] as num).toDouble(),
      height: (data['height'] as num).toDouble(),
      period: data['period'] ?? '',
      cycle: data['cycle'], 
      last: (data['last'] as Timestamp).toDate(),
    );
  }
}

Future<SetUpDates?> getUserData() async {
  final userId = FirebaseAuth.instance.currentUser?.uid;

  if (userId == null) return null;

  try {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    if (docSnapshot.exists) {
      return SetUpDates.fromFirestore(docSnapshot.data()!);
    }
    return null;
  } catch (e) {
    print('Error fetching user data: $e');
    return null;
  }
}

