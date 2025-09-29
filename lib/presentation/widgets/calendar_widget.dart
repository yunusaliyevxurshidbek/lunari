import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime currentMonth;
  final DateTime selectedDate;
  final DateTime? lastDate;
  final int? period;
  final DateTime? ovulationDate;
  final int ovulationDays = 4;
  final List<DateTime> editedDates;
  final ValueChanged<DateTime> onDayTapped;

  const CalendarWidget({
    super.key,
    required this.currentMonth,
    required this.selectedDate,
    required this.onDayTapped,
    this.lastDate,
    this.period,
    this.ovulationDate,
    this.editedDates = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                .map((d) => Expanded(
              child: Center(
                child: Text(
                  d,
                  style: GoogleFonts.urbanist(
                    fontSize: 15.sp,
                    color: context.ccolors.greyScale700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ))
                .toList(),
          ),
        ),
        Table(
          border: TableBorder.all(
              color: context.ccolors.dividerLight, width: 1
          ),
          defaultColumnWidth: const FlexColumnWidth(),
          children: _buildCalendarRows(context),
        ),
      ],
    );
  }

  List<TableRow> _buildCalendarRows(BuildContext context) {
    final days = _generateDaysForMonth(currentMonth);

    final useEdited = editedDates.isNotEmpty;
    DateTime? start, end;
    if (!useEdited && lastDate != null && period != null && period! > 0) {
      start = DateTime(lastDate!.year, lastDate!.month, lastDate!.day);
      end = start.add(Duration(days: period! - 1));
    }

    final List<DateTime> ovulationDates = [];
    if (ovulationDate != null) {
      for (int i = 0; i < ovulationDays; i++) {
        ovulationDates.add(ovulationDate!.add(Duration(days: i)));
      }
    }

    return List.generate(6, (rowIdx) {
      final week = days.skip(rowIdx * 7).take(7).toList();

      return TableRow(
        children: week.map((date) {
          final day = date.day;
          final isToday = _isSameDay(date, DateTime.now());
          final isSelected = _isSameDay(date, selectedDate);
          final inMonth = date.month == currentMonth.month;

          final inRange = !useEdited
              && start != null && end != null
              && !date.isBefore(start)
              && !date.isAfter(end);

          final isOvulationDay = ovulationDates.any((d) => _isSameDay(d, date));
          final isEdited = editedDates.any((d) => _isSameDay(d, date));

          Color bg;
          if (isOvulationDay) {
            bg = const Color(0xFFFF981F);
          } else if (isEdited) {
            bg = const Color(0xFFFF699C);
          } else if (isToday) {
            bg = context.ccolors.greyScale600;
          } else if (inRange && isSelected) {
            bg = Colors.blueAccent;
          } else if (inRange) {
            bg = context.colors.primary;
          } else if (isSelected) {
            bg = Colors.blueAccent;
          } else if (!inMonth) {
            bg = context.colors.onPrimary;
          } else {
            bg = context.colors.onPrimary;
          }

          Color txt;
          if (isOvulationDay || isEdited || isSelected) {
            txt = Colors.white;
          } else if (!inMonth) {
            txt = context.colors.textLight;
          } else if (isToday) {
            txt = context.colors.onPrimary;
          } else if (inRange) {
            txt = context.ccolors.onPrimary;
          } else {
            txt = context.colors.scrim;
          }

          return GestureDetector(
            onTap: () => onDayTapped(date),
            child: Container(
              height: 48,
              color: bg,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('$day',
                    style: GoogleFonts.urbanist(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: txt,
                    ),
                  ),
                  if (inRange) ...[
                    const SizedBox(height: 2),
                    Icon(Icons.water_drop, size: 15, color: context.ccolors.alert),
                  ],
                ],
              ),
            ),
          );
        }).toList(),
      );
    });
  }

  List<DateTime> _generateDaysForMonth(DateTime month) {
    final first = DateTime(month.year, month.month, 1);
    final offset = first.weekday % 7;
    final gridStart = first.subtract(Duration(days: offset));
    return List.generate(42, (i) => gridStart.add(Duration(days: i)));
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
