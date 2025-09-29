import 'package:equatable/equatable.dart';
import 'package:lunari/data/models/log_count_model.dart';

abstract class LogCountState extends Equatable {
  const LogCountState();

  @override
  List<Object?> get props => [];
}

class LogCountInitial extends LogCountState {}
class LogCountLoading extends LogCountState {}

class LogCountLoaded extends LogCountState {
  final List<LogCountEntry> entries;
  const LogCountLoaded(this.entries);

  @override
  List<Object?> get props => [entries];
}

class LogCountError extends LogCountState {
  final String message;
  const LogCountError(this.message);

  @override
  List<Object?> get props => [message];
}