part of 'edit_period_bloc.dart';

abstract class EditPeriodState {}

class EditPeriodInitial extends EditPeriodState {}

class EditPeriodLoading extends EditPeriodState {}

class EditPeriodLoaded extends EditPeriodState {
  final List<DateTime> selectedDates;
  EditPeriodLoaded(this.selectedDates);
}

class EditPeriodSaved extends EditPeriodState {}

class EditPeriodError extends EditPeriodState {
  final String message;
  EditPeriodError(this.message);
}