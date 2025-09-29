class SetupState {
  final int currentStep;
  final String? errorMessage;
  final String name;
  final String birthday;
  final double weight;
  final double height;
  final int period;
  final bool cycleType;
  final int cycleMin;
  final int cycleMax;
  final List<String> last;



  const SetupState({
    this.currentStep = 0,
    this.errorMessage,
    this.name = '',
    this.birthday = "2000-01-01",
    this.weight = 50,
    this.height = 160,
    this.period = 4,
    this.cycleType = true,
    this.cycleMin = 27,
    this.cycleMax = 29,
    this.last = const [],
  });


  SetupState copyWith({
    int? currentStep,
    String? errorMessage,
    String? name,
    String? birthday,
    double? weight,
    double? height,
    int? period,
    int? cycle,
    bool? cycleType,
    int? cycleMin,
    int? cycleMax,
    List<String>? last,
  }) {
    return SetupState(
      currentStep: currentStep ?? this.currentStep,
      errorMessage: errorMessage,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      period: period ?? this.period,
      cycleType: cycleType ?? this.cycleType,
      cycleMin: cycleMin ?? this.cycleMin,
      cycleMax: cycleMax ?? this.cycleMax,
      last: last ?? this.last,
    );
  }
}
