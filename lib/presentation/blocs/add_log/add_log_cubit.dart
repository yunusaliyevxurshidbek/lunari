import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunari/core/services/log_service.dart';
import 'add_log_state.dart';

class AddLogCubit extends Cubit<AddLogState> {
  AddLogCubit() : super(AddLogState());

  void selectDate(DateTime newDate) async{
    emit(state.copyWith(date: newDate));
    LogService.i("Selected Date: $newDate");

    final docId = DateFormat("yyyy-MM-dd").format(newDate);
    await fetchDataById(docId);
  }

  Future<void> fetchDataById(String logId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('AddLog')
          .doc(logId)
          .get();

      if (!snapshot.exists) {
        final selectedDate = DateFormat("yyyy-MM-dd").parse(logId);
        emit(AddLogState(date: selectedDate));
        LogService.i("No data for logId: $logId");
        return;
      }
      final data = snapshot.data() as Map<String, dynamic>;

      String? savedDate = data['date'];
      DateTime parsedDate = savedDate != null
      ? DateFormat("dd.MM.yyyy").parse(savedDate)
      : state.date;

      emit(state.copyWith(
        selectedFlow: data['selectedFlow'] ?? "",
        selectedSymptoms: List<String>.from(data['selectedSymptoms'] ?? []),
        selectedMoods: List<String>.from(data['selectedMoods'] ?? []),
        selectedMedicines: List<String>.from(data['selectedMedicines'] ?? []),
        note: data['note'] ?? "",
        weight: data['weight'] ?? 0.0,
        temperature: data['temperature'] ?? 0.0,
        totalWaterConsumed: data['totalWaterConsumed'] ?? 0,
        lastConsumedWater: data['lastConsumedWater'] ?? 0,
        lastConsumedIcon: data['lastConsumedIcon'] ?? "",
        date: parsedDate,
      ));

      LogService.i("Data fetched successfully for logId: $logId");
    } catch (e) {
      LogService.e("Failed to fetch data for logId $logId: $e");
    }
  }

  void selectFlow(String flow) {
    emit(state.copyWith(selectedFlow: flow));
    LogService.i("Selected Flow: $flow");
  }

  void toggleSymptom(String symptom) {
    final updatedSymptoms = List<String>.from(state.selectedSymptoms);
    if (updatedSymptoms.contains(symptom)) {
      updatedSymptoms.remove(symptom);
    } else {
      updatedSymptoms.add(symptom);
    }
    emit(state.copyWith(selectedSymptoms: updatedSymptoms));
    LogService.i("Selected symptoms: ${state.selectedSymptoms}");
  }

  void toggleMood(String mood) {
    final updatedMoods = List<String>.from(state.selectedMoods);
    if (updatedMoods.contains(mood)) {
      updatedMoods.remove(mood);
    } else {
      updatedMoods.add(mood);
    }
    emit(state.copyWith(selectedMoods: updatedMoods));
    LogService.i("Selected moods: ${state.selectedMoods}");
  }

  void toggleMedicine(String medicine) {
    final updatedMedicines = List<String>.from(state.selectedMedicines);
    if (updatedMedicines.contains(medicine)) {
      updatedMedicines.remove(medicine);
    } else {
      updatedMedicines.add(medicine);
    }
    emit(state.copyWith(selectedMedicines: updatedMedicines));
    LogService.i("Selected medicine: ${state.selectedMedicines}");
  }

  void updateNote(String note) {
    emit(state.copyWith(note: note));
    LogService.i("Note: $note");
  }

  void updateWeight(double weight) {
    emit(state.copyWith(weight: weight));
    LogService.i("Weight : $weight");
  }

  void updateTemperature(double temperature) {
    emit(state.copyWith(temperature: temperature));
    LogService.i("Temperature: $temperature");
  }

  void updateWaterConsumption({
    int? total,
  }) {
    emit(state.copyWith(
      totalWaterConsumed: total ?? state.totalWaterConsumed,
    ));
    LogService.i("Water updated: Total: ${state.totalWaterConsumed}ml");
  }

  void updateLastConsumedWater({
    required num lastConsumedWater,
    required String lastConsumedIcon,
  }) {
    final waterInt = lastConsumedWater.toInt();
    emit(state.copyWith(
      lastConsumedWater: waterInt,
      lastConsumedIcon: lastConsumedIcon,
    ));
    LogService.i("Last consumed water updated: ${waterInt}ml, icon: $lastConsumedIcon");
  }

  void addWaterConsumption({
    required num amount,
    required String icon,
  }) {
    final amountInt = amount.toInt();
    final newTotal = state.totalWaterConsumed + amountInt;
    emit(state.copyWith(
      totalWaterConsumed: newTotal,
      lastConsumedWater: amountInt,
      lastConsumedIcon: icon,
    ));
    LogService.i("Water consumption added: ${amountInt}ml, Total: ${newTotal}ml");
  }

  void resetWaterConsumption() {
    emit(state.copyWith(
      totalWaterConsumed: 0,
      lastConsumedWater: 0,
      lastConsumedIcon: "",
    ));
    LogService.i("Water consumption reset");
  }

  Future<void> saveData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final date = state.date;
    final docId = DateFormat('yyyy-MM-dd').format(date);
    final formattedDate = DateFormat('dd.MM.yyyy').format(date);

    final data = {
      'selectedFlow': state.selectedFlow,
      'selectedSymptoms': state.selectedSymptoms,
      'selectedMoods': state.selectedMoods,
      'selectedMedicines': state.selectedMedicines,
      'note': state.note,
      'weight': state.weight,
      'temperature': state.temperature,
      'totalWaterConsumed': state.totalWaterConsumed,
      'lastConsumedWater': state.lastConsumedWater,
      'lastConsumedIcon': state.lastConsumedIcon,
      'date': formattedDate,
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('AddLog')
          .doc(docId)
          .set(data, SetOptions(merge: true));

      LogService.i("Data saved successfully for date: $formattedDate");
    } catch (e) {
      LogService.e("Failed to save data: $e");
      rethrow;
    }
  }

  void resetState() {
    emit(AddLogState());
  }
}
