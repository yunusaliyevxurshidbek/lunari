abstract class SetupEvent {}

class NameChanged extends SetupEvent {
  final String name;
  NameChanged(this.name);
}

class BirthdayChanged extends SetupEvent {
  final String birthday;
  BirthdayChanged(this.birthday);
}

class WeightChanged extends SetupEvent {
  final double weight;
  WeightChanged(this.weight);
}

class HeightChanged extends SetupEvent {
  final double height;
  HeightChanged(this.height);
}

class PeriodChanged extends SetupEvent {
  final int period;
  PeriodChanged(this.period);
}


class CycleTypeChanged extends SetupEvent {
  final bool isRegular;
  CycleTypeChanged(this.isRegular);
}

class CycleRangeChanged extends SetupEvent {
  final int min;
  final int max;
  CycleRangeChanged(this.min, this.max);
}


class LastChanged extends SetupEvent {
  final List<String> last;
  LastChanged(this.last);
}

class ValidateStep extends SetupEvent {}


class NextStep extends SetupEvent {}

class PreviousStep extends SetupEvent {}

class NavigateToPersonalizingPage extends SetupEvent {}

