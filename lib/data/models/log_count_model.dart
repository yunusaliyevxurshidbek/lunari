import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class  LogCountEntry extends Equatable {
  final DateTime date;
  final String? selectedFlow;
  final List<String> selectedMedicines;
  final List<String> selectedMoods;
  final List<String> selectedSymptoms;

  LogCountEntry({
    required this.date,
    this.selectedFlow,
    this.selectedMedicines = const [],
    this.selectedMoods = const [],
    this.selectedSymptoms = const [],
});

  factory LogCountEntry.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    return LogCountEntry(
      date: DateTime.parse(doc.id),
      selectedFlow: data?["selectedFlow"] as String?,
      selectedMedicines: List<String>.from(data?['selectedMedicines'] ?? []),
      selectedSymptoms: List<String>.from(data?['selectedSymptoms'] ?? []),
      selectedMoods: List<String>.from(data?['selectedMoods'] ?? []),
    );
  }

  @override
  List<Object?> get props => [date, selectedFlow, selectedMedicines, selectedSymptoms];
}
