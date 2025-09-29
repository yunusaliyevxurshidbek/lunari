import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';

class LogEntry {
  final DateTime date;
  final double temperature;
  final double totalWaterConsumed;
  final double weight;

  LogEntry({
    required this.date,
    required this.temperature,
    required this.totalWaterConsumed,
    required this.weight,
  });

  factory LogEntry.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();

    if (data == null) {
      throw Exception('Document ${doc.id} does not exist!');
    }

    DateTime parsedDate;
    try {
      parsedDate = DateFormat('yyyy-MM-dd').parse(doc.id);
    } catch (e) {
      final timestamp = data['createdTime'] as Timestamp?;
      if (timestamp != null) {
        parsedDate = timestamp.toDate();
      } else {
        parsedDate = DateTime.now();
      }
    }

    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return LogEntry(
      date: parsedDate,
      temperature: parseDouble(data['temperature']),
      totalWaterConsumed: parseDouble(data['totalWaterConsumed']),
      weight: parseDouble(data['weight']),
    );
  }
}
