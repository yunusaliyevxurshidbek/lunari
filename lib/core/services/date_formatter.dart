import 'package:intl/intl.dart';

String formatDate(String dateString) {
  DateTime date = DateFormat("dd.MM.yyyy").parse(dateString);
  return DateFormat("MMM dd").format(date);
}