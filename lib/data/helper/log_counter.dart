import '../models/log_count_model.dart';

Map<String, dynamic> aggregateCounts(List<LogCountEntry> entries) {
  final flowCounts = {
    'Light': 0,
    'Medium': 0,
    'Heavy': 0,
    'Disaster': 0,
  };

  final symptomCounts = {
    'Headaches': 0,
    'Insomnia': 0,
    'Breast-Tend': 0,
    'Mood-Change': 0,
    'Hot Flashes': 0,
    'Vaginal Dryness': 0,
    'Night Sweats': 0,
    'Thinning Hair': 0,
    'Weight Gain': 0,
    'Irregular Period': 0,
    'Memory Problem': 0,
    'Joint Pain': 0,
  };

  final moodCounts = {
    'Normal': 0,
    'Angry': 0,
    'Happy': 0,
    'Sad': 0,
    'Exhausted': 0,
    'Anxious': 0,
    'Depressed': 0,
    'In Love': 0,
    'Bored': 0,
    'Confident': 0,
    'Excited': 0,
    'Relaxed': 0,
  };

  final medicineCounts = {
    'Condom': 0,
    'Pill': 0,
    'Spermicide': 0,
    'Ring': 0,
    'IUD': 0,
    'Shot': 0,
    'Implant': 0,
    'Patch': 0,
  };

  for (var entry in entries) {
    flowCounts[entry.selectedFlow.toString()] = (flowCounts[entry.selectedFlow] ?? 0) + 1;

    for (var symptom in entry.selectedSymptoms) {
      final normalizedSymptom = symptom == 'Mood Changes' ? 'Mood-Change' : symptom;
      if (symptomCounts.containsKey(normalizedSymptom)) {
        symptomCounts[normalizedSymptom] = symptomCounts[normalizedSymptom]! + 1;
      }
    }

    for (var mood in entry.selectedMoods) {
      if (moodCounts.containsKey(mood)) {
        moodCounts[mood] = moodCounts[mood]! + 1;
      }
    }

    for (var medicine in entry.selectedMedicines) {
      if (medicineCounts.containsKey(medicine)) {
        medicineCounts[medicine] = medicineCounts[medicine]! + 1;
      }
    }
  }

  return {
    'flow': flowCounts,
    'symptoms': symptomCounts,
    'moods': moodCounts,
    'medicines': medicineCounts,
  };
}