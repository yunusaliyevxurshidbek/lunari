import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunari/data/models/ringtone_model.dart';
import 'package:lunari/presentation/blocs/ringtone/ringtone_state.dart';

class RingtoneCubit extends Cubit<RingtoneState> {
  RingtoneCubit() : super(RingtoneInitial());

  void selectedRingtone(Ringtone ringtone) {
    emit(RingtoneSelected(ringtone));
  }
}