import 'package:equatable/equatable.dart';
import '../../../data/models/calendar_model.dart';

class AddLogState extends Equatable {
  final String? selectedFlow;
  final List<String> selectedSymptoms;
  final List<String> selectedMoods;
  final List<String> selectedMedicines;
  final String note;
  final double weight;
  final double temperature;
  final DateTime date;
  final int totalWaterConsumed;
  final int lastConsumedWater;
  final String lastConsumedIcon;
  final CalendarEditModel? log;

  AddLogState({
    this.selectedFlow,
    this.selectedSymptoms = const [],
    this.selectedMoods = const [],
    this.selectedMedicines = const [],
    this.note = '',
    this.weight = 0.0,
    this.temperature = 0.0,
    DateTime? date,
    this.totalWaterConsumed = 0,
    this.lastConsumedWater = 0,
    this.lastConsumedIcon = "",
    this.log,
  }) : date = date ?? DateTime.now();

  AddLogState copyWith({
    String? selectedFlow,
    List<String>? selectedSymptoms,
    List<String>? selectedMoods,
    List<String>? selectedMedicines,
    String? note,
    double? weight,
    double? temperature,
    DateTime? date,
    int? totalWaterConsumed,
    int? lastConsumedWater,
    String? lastConsumedIcon,
    CalendarEditModel? log
  }) {
    return AddLogState(
      selectedFlow: selectedFlow ?? this.selectedFlow,
      selectedSymptoms: selectedSymptoms ?? this.selectedSymptoms,
      selectedMoods: selectedMoods ?? this.selectedMoods,
      selectedMedicines: selectedMedicines ?? this.selectedMedicines,
      note: note ?? this.note,
      weight: weight ?? this.weight,
      temperature: temperature ?? this.temperature,
      date: date ?? this.date,
      totalWaterConsumed: totalWaterConsumed ?? this.totalWaterConsumed,
      lastConsumedWater: lastConsumedWater ?? this.lastConsumedWater,
      lastConsumedIcon: lastConsumedIcon ?? this.lastConsumedIcon,
      log: log ?? this.log,
    );
  }

  @override
  List<Object?> get props => [
    selectedFlow,
    selectedSymptoms,
    selectedMoods,
    selectedMedicines,
    note,
    weight,
    temperature,
    date,
    totalWaterConsumed,
    lastConsumedWater,
    lastConsumedIcon,
  ];
}