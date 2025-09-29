class AddLogModel {
  final String flow;
  final List<String> symptoms;
  final List<String> moods;
  final List<String> medicines;
  final String note;
  final double weight;
  final double temperature;
  final DateTime date;

  AddLogModel({
    required this.flow,
    required this.symptoms,
    required this.moods,
    required this.medicines,
    required this.note,
    required this.weight,
    required this.temperature,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'flow': flow,
      'symptoms': symptoms,
      'moods': moods,
      'medicines': medicines,
      'note': note,
      'weight': weight,
      'temperature': temperature,
      'date': date.toIso8601String(),
    };
  }
}
