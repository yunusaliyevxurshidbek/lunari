import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lunari/core/style/app_theme.dart';
import '../../../../../data/models/log_entry.dart';
import '../../views/chart_types.dart';


class MyLineGraph extends StatelessWidget {
  final YAxisType yAxisType;
  final DateTime startOfWeek;
  final DateTime endOfWeek;
  final List<LogEntry>? logs;

  const MyLineGraph({
    super.key,
    required this.yAxisType,
    required this.startOfWeek,
    required this.endOfWeek,
    this.logs,
  });

  Color _getLineColor() {
    switch (yAxisType) {
      case YAxisType.weight:
        return const Color(0xFF8BC255);
      case YAxisType.liters:
        return const Color(0xFF1A96F0);
      case YAxisType.temperature:
        return const Color(0xFFFF981F);
    }
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

    final spots = <FlSpot>[];
    for (int i = 0; i < 7; i++) {
      final day = startOfWeek.add(Duration(days: i));
      final key = DateFormat('yyyy-MM-dd').format(day);
      final value = mapByDate[key] ?? 0.0;
      spots.add(FlSpot(i.toDouble(), value));
    }

    late List<double> fixedValues;
    late String Function(double) getTitle;
    late double minY;
    late double maxY;

    switch (yAxisType) {
      case YAxisType.liters:
        fixedValues = [0, 1, 1.5, 2, 2.5, 3, 4];
        getTitle = (v) => '${v}L';
        minY = -0.2;
        maxY = 4.2;
        break;
      case YAxisType.temperature:
        fixedValues = [35.5, 36, 37, 37.5];
        getTitle = (v) => '${v}°C';
        minY = 35.3;
        maxY = 37.7;
        break;
      case YAxisType.weight:
      default:
        fixedValues = List.generate(11, (i) => i * 10.0);
        getTitle = (v) => '${v.toInt()}';
        minY = -5;
        maxY = 105;
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 16),
      child: LineChart(
        LineChartData(
          maxY: maxY,
          minY: minY,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: _getLineColor(),
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  final todayIndex =
                      DateTime.now().difference(startOfWeek).inDays;
                  final isToday = index == todayIndex;
                  return FlDotCirclePainter(
                    radius: isToday ? 6 : 4,
                    color: Colors.white,
                    strokeWidth: isToday ? 3 : 2,
                    strokeColor: _getLineColor(),
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                color: _getLineColor().withOpacity(0.2),
              ),
            ),
          ],
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  if (fixedValues.any((f) => (value - f).abs() < 0.01)) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        getTitle(value),
                        style: GoogleFonts.urbanist(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: context.ccolors.greyScale600,
                        ),
                        textAlign: TextAlign.right,
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
                interval: 1,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  final idx = value.toInt();
                  if (idx < 0 || idx > 6) return const SizedBox.shrink();
                  final day = startOfWeek.add(Duration(days: idx));
                  final label = DateFormat('d').format(day);
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      label,
                      style: GoogleFonts.urbanist(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: context.ccolors.greyScale600,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            drawHorizontalLine: false,
            horizontalInterval: yAxisType == YAxisType.liters ? 0.5 :
            yAxisType == YAxisType.temperature ? 0.5 : 10,
            getDrawingHorizontalLine: (value) {
              if (fixedValues.any((f) => (value - f).abs() < 0.01)) {
                return FlLine(
                  color: Colors.grey.withOpacity(0.15),
                  strokeWidth: 0.8,
                );
              }
              return const FlLine(color: Colors.transparent);
            },
          ),
          borderData: FlBorderData(show: false),
          extraLinesData: ExtraLinesData(
            horizontalLines: [],
          ),
        ),
      ),
    );
  }
}
