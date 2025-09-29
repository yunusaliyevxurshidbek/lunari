import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/screens/setup/components/select_data.dart';
import '../../../blocs/setup/setup_bloc.dart';
import '../../../blocs/setup/setup_event.dart';

class LastStep extends StatefulWidget {
  const LastStep({super.key});

  @override
  State<LastStep> createState() => _LastStepState();
}

class _LastStepState extends State<LastStep> {
  DateTime currentDate = DateTime.now();
  List<DateTime> selectedDates = [];

  void toggleDateSelection(DateTime date) {
    if (date.isAfter(currentDate)) return;

    setState(() {
      selectedDates.removeWhere((d) => d.month == date.month && d.year == date.year);
      selectedDates.add(date);
    });

    List<String> formattedDates =
    selectedDates.map((date) => DateFormat("dd.MM.yyyy").format(date)).toList();
    context.read<SetupBloc>().add(LastChanged(formattedDates));
  }

  List<DateTime> generateDatesForMonth(DateTime month) {
    List<DateTime> dates = [];
    DateTime firstDay = DateTime(month.year, month.month, 1);
    DateTime lastDay = DateTime(month.year, month.month + 1, 0);

    for (int i = 0; i <= lastDay.difference(firstDay).inDays; i++) {
      dates.add(firstDay.add(Duration(days: i)));
    }

    return dates;
  }

  @override
  Widget build(BuildContext context) {
    DateTime previousMonth = DateTime(
        currentDate.year, currentDate.month == 1 ? 12 : currentDate.month - 1, 1);

    List<DateTime> previousMonthDates = generateDatesForMonth(previousMonth);
    List<DateTime> currentMonthDates = generateDatesForMonth(currentDate);

    return Column(
      children: [
        Text(
          "last_period_start".tr(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),

        Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: context.colors.onPrimary,
            borderRadius: BorderRadius.circular(6),
          ),
          child: SelectData(
            dates: currentMonthDates,
            selectedDates: selectedDates,
            onDateSelected: toggleDateSelection,
            isSelectable: (date) => !date.isAfter(currentDate),
          ),
        ),
        const SizedBox(height: 16),

        Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: context.colors.onPrimary,
            borderRadius: BorderRadius.circular(6),
          ),
          child: SelectData(
            dates: previousMonthDates,
            selectedDates: selectedDates,
            onDateSelected: toggleDateSelection,
            isSelectable: (date) => !date.isAfter(currentDate),
          ),
        ),
      ],
    );
  }
}
