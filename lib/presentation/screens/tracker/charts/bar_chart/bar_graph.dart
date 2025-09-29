import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/data/models/log_entry.dart';
import '../../views/chart_types.dart';


class MyBarGraph extends StatelessWidget {
  final YAxisType yAxisType;
  final DateTime startOfWeek, endOfWeek;
  final List<LogEntry>? logs;

  const MyBarGraph({
    super.key,
    required this.yAxisType,
    required this.startOfWeek,
    required this.endOfWeek,
    this.logs,
  });

  Color _getBarColor(int index) {
    late Color primaryColor;
    late Color secondaryColor;

    switch (yAxisType) {
      case YAxisType.weight:
        primaryColor = const Color(0xFF8BC255);
        secondaryColor = const Color(0xFFCCE5B7);
        break;
      case YAxisType.liters:
        primaryColor = const Color(0xFF1A96F0);
        secondaryColor = primaryColor.withOpacity(0.5);
        break;
      case YAxisType.temperature:
        primaryColor = const Color(0xFFFF981F);
        secondaryColor = primaryColor.withOpacity(0.5);
        break;
    }

    final todayIndex = DateTime.now().difference(startOfWeek).inDays;
    return index == todayIndex ? primaryColor : secondaryColor;
  }

  @override
  Widget build(BuildContext context) {
    final mapByDate = <String, double>{};
    for (var log in logs!) {
      final key = DateFormat('yyyy-MM-dd').format(log.date);
      switch (yAxisType) {
        case YAxisType.weight:
          mapByDate[key] = log.weight;
          break;
        case YAxisType.liters:
          mapByDate[key] = log.totalWaterConsumed;
          break;
        case YAxisType.temperature:
          mapByDate[key] = log.temperature;
          break;
      }
    }

    final data = List<double>.generate(7, (i) {
      final d = startOfWeek.add(Duration(days: i));
      final key = DateFormat('yyyy-MM-dd').format(d);
      return mapByDate[key] ?? 0.0;
    });

    late List<double> fixedValues;
    late String Function(double) getTitle;
    switch (yAxisType) {
      case YAxisType.liters:
        fixedValues = [0, 1, 1.5, 2, 2.5, 3, 4];
        getTitle = (v) => '${v}L';
        break;
      case YAxisType.temperature:
        fixedValues = [0, 35.5, 36, 37, 37.5];
        getTitle = (v) => '${v}°C';
        break;
      case YAxisType.weight:
      default:
        fixedValues = List.generate(11, (i) => i * 10.0);
        getTitle = (v) => '${v.toInt()}';
        break;
    }

    final barGroups = List.generate(7, (i) {
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: data[i],
            color: _getBarColor(i),
            width: 25,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
        ],
      );
    });

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: BarChart(
        BarChartData(
          maxY: fixedValues.last,
          minY: fixedValues.first,
          barGroups: barGroups,
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  if (fixedValues.any((f) => (value - f).abs() < 0.1)) {
                    return Text(
                      getTitle(value),
                      style: GoogleFonts.urbanist(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: context.ccolors.greyScale700
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final idx = value.toInt();
                  if (idx < 0 || idx > 6) return const SizedBox.shrink();
                  final day = startOfWeek.add(Duration(days: idx));
                  final label = DateFormat('d').format(day);
                  return Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      label,
                      style: GoogleFonts.urbanist(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                          color: context.ccolors.greyScale700
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          gridData: const FlGridData(show: false),
          borderData:  FlBorderData(show: false),
        ),
      ),
    );
  }
}
