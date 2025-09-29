import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lunari/presentation/blocs/setup/setup_event.dart';
import 'package:lunari/presentation/blocs/setup/setup_state.dart';

class SetupBloc extends Bloc<SetupEvent, SetupState> {
  final PageController pageController = PageController();

  SetupBloc() : super(const SetupState()) {
    on<NameChanged>(_onNameChanged);
    on<BirthdayChanged>((event, emit) {
      emit(state.copyWith(birthday: event.birthday));
    });
    on<WeightChanged>((event, emit) {
      emit(state.copyWith(weight: event.weight));
    });
    on<HeightChanged>((event, emit) {
      emit(state.copyWith(height: event.height));
    });
    on<PeriodChanged>((event, emit) {
      emit(state.copyWith(period: event.period));
    });
    on<CycleTypeChanged>((event, emit) {
      emit(state.copyWith(cycleType: event.isRegular));
    });
    on<CycleRangeChanged>((event, emit) {
      emit(state.copyWith(cycleMin: event.min, cycleMax: event.max));
    });
    on<LastChanged>((event, emit) {
      emit(state.copyWith(last: event.last));
    });
    on<ValidateStep>(_onValidateStep);
    on<NextStep>(_onNextStep);
    on<PreviousStep>((event, emit) {
      if (state.currentStep > 0) {
        emit(state.copyWith(currentStep: state.currentStep - 1));
      }
    });
    on<NavigateToPersonalizingPage>((event, emit) {
      emit(state.copyWith(currentStep: 7));
    });
  }

  Future<bool> isNicknameUnique(String name) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: name)
        .get();
    return querySnapshot.docs.isEmpty;
  }

  void _onNameChanged(NameChanged event, Emitter<SetupState> emit) {
    emit(state.copyWith(name: event.name, errorMessage: null));
  }


  Future<void> _onValidateStep(ValidateStep event, Emitter<SetupState> emit) async {
    if (state.currentStep == 0) {
      if (state.name.isEmpty) {
        emit(state.copyWith(errorMessage: "Please,enter your Nickname!"));
        return;
      }

      bool isUnique = await isNicknameUnique(state.name);
      if (!isUnique) {
        emit(state.copyWith(errorMessage: "This nickname is taken! Choose another one!"));
        return;
      }
    }

    if (!_isCurrentStepValid(state.currentStep)) {
      emit(state.copyWith(errorMessage: "Please,fill all fields!!"));
    } else {
      emit(state.copyWith(errorMessage: null));
      add(NextStep());
    }
  }


  void _onNextStep(NextStep event, Emitter<SetupState> emit) {
    if (state.currentStep < 6) {
      pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  bool _isCurrentStepValid(int step) {
    switch (step) {
      case 0:
        return state.name.isNotEmpty;
      case 1: // BirthdayStep
        return state.birthday != null && state.birthday.toString().isNotEmpty;
      case 2: // WeightStep
        return state.weight > 0;
      case 3: // HeightStep
        return state.height > 0;
      case 4: // PeriodStep
        return state.period > 0;
      case 5: // CycleStep
        return state.cycleMin > 0;
      case 6: // LastStep
        return state.last != null && state.last.toString().isNotEmpty;
      default:
        return true;
    }
  }
}
