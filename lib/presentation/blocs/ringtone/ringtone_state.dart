import '../../../data/models/ringtone_model.dart';

abstract class RingtoneState {}

class RingtoneInitial extends RingtoneState {}

class RingtoneSelected extends RingtoneState {
  final Ringtone ringtone;

  RingtoneSelected(this.ringtone);
}
