import 'package:equatable/equatable.dart';

abstract class TrackerEvent extends Equatable {
  const TrackerEvent();
  @override List<Object> get props => [];
}

class LoadTrackerData extends TrackerEvent {}