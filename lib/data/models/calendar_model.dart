import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarEditModel {
  final String date;
  final String cycleDay;
  final String selectedFlow;
  final List<String> selectedSymptoms;
  final List<String> selectedMoods;
  final List<String> selectedMedicines;
  final String note;
  final double weight;
  final double temperature;
  final DateTime? timestamp;
  final String? id;

  CalendarEditModel({
    required this.date,
    required this.cycleDay,
    required this.selectedFlow,
    required this.selectedSymptoms,
    required this.selectedMoods,
    required this.selectedMedicines,
    required this.note,
    required this.weight,
    required this.temperature,
    this.timestamp,
    this.id,
  });

  factory CalendarEditModel.fromFirestore(Map<String, dynamic> data,String id) {
    return CalendarEditModel(
      date: data['date'] ?? '',
      cycleDay: data['cycleDay'] ?? 'Cycle Day 1',
      selectedFlow: data['selectedFlow'] ?? '',
      selectedSymptoms: List<String>.from(data['selectedSymptoms'] ?? []),
      selectedMoods: List<String>.from(data['selectedMoods'] ?? []),
      selectedMedicines: List<String>.from(data['selectedMedicines'] ?? []),
      note: data['note'] ?? '',
      weight: (data['weight'] ?? 0).toDouble(),
      temperature: (data['temperature'] ?? 0).toDouble(),
      timestamp: (data['timestamp'] as Timestamp?)?.toDate(),
      id: id,
    );
  }

  @override
  String toString() {
    return 'CalendarEditModel('
        'date: $date, '
        'cycleDay: $cycleDay, '
        'selectedFlow: $selectedFlow, '
        'selectedSymptoms: $selectedSymptoms, '
        'selectedMoods: $selectedMoods, '
        'selectedMedicines: $selectedMedicines, '
        'note: $note, '
        'weight: $weight, '
        'temperature: $temperature, '
        'timestamp: $timestamp, '
        'id: $id)';
  }
}