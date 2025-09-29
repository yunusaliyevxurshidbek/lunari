class UserData {
  String? name;
  double? weight;
  int? age;
  double? height;
  int? period;
  int? cycle;
  DateTime? last;

  UserData({
    this.name,
    this.weight,
    this.age,
    this.height,
    this.period,
    this.cycle,
    this.last,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'weight': weight,
      'age': age,
      'height': height,
      'period': period,
      'cycle': cycle,
      'last': last?.toIso8601String(),
    };
  }
}
