class FirestoreModel {
  final String? birthday;
  final int? period;
  final List<String>? last;
  final double? weight;
  final String? userId;
  final int? cycle;
  final String? signUpMethod;
  final String? createdAt;
  final String? name;
  final String? email;
  final double? height;

  FirestoreModel({
     this.birthday,
     this.period,
     this.last,
     this.weight,
     this.userId,
     this.cycle,
     this.signUpMethod,
     this.createdAt,
     this.name,
     this.email,
     this.height,
  });

  factory FirestoreModel.fromJson(Map<String, dynamic> json) {
    return FirestoreModel(
      birthday: json['birthday'] ?? '',
      period: json['period'] ?? 0,
      last: List<String>.from(json['last'] ?? []),
      weight: (json['weight'] ?? 0.0).toDouble(),
      userId: json['userId'] ?? '',
      cycle: json['cycle'] ?? 0,
      signUpMethod: json['signUpMethod'] ?? '',
      createdAt: json['createdAt'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      height: (json['height'] ?? 0.0).toDouble(),
    );
  }
}
