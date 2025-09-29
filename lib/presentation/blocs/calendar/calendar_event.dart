import '../../../data/models/calendar_model.dart';

abstract class CalendarEvent {}
class LoadLogs extends CalendarEvent {}
class SubscribeToLogs extends CalendarEvent {}
class UpdateLogs extends CalendarEvent {
  final List<CalendarEditModel> logs;
  UpdateLogs(this.logs);
}
class DateSelected extends CalendarEvent {
  final DateTime date;
  DateSelected(this.date);
}
class LoadUserData extends CalendarEvent {}
class UpdateUserData extends CalendarEvent {
  final DateTime? last;
  final int? period;
  final List<int>? cycle;
  UpdateUserData({this.last, this.period, this.cycle});
}
