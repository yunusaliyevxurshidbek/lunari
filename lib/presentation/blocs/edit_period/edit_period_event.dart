part of 'edit_period_bloc.dart';

abstract class EditPeriodEvent {}

class LoadSelectedDates extends EditPeriodEvent {}

class ToggleDateSelection extends EditPeriodEvent {
  final DateTime date;
  ToggleDateSelection(this.date);
}

class SaveSelectedDates extends EditPeriodEvent {}