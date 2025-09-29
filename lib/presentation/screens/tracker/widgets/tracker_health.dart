import 'package:flutter/material.dart';
import '../charts/bmi_chart/gauges_chart.dart';
import '../views/bar_chart_panels/temperature_panel.dart';
import '../views/bar_chart_panels/water_panel.dart';
import '../views/bar_chart_panels/weight_panel.dart';


class BuildHealthSection extends StatefulWidget {
  const BuildHealthSection({super.key});

  @override
  State<BuildHealthSection> createState() => _BuildHealthSectionState();
}

class _BuildHealthSectionState extends State<BuildHealthSection> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 24,
        children: [
          WeightPanel(),
          BMIScreen(),
          TemperaturePanel(),
          WaterPanel(),
        ],
      ),
    );
  }
}
