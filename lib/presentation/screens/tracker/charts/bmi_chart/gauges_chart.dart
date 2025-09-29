import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'build_bmi_item.dart';

class BMIScreen extends StatelessWidget {
  const BMIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "BMI",
                style: GoogleFonts.urbanist(
                    fontSize: 20.sp, fontWeight: FontWeight.w700),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF4AAF57),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "normal".tr(),
                  style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: context.colors.onTertiary,
            thickness: 1,
            height: 0,
          ),
          SizedBox(
            width: 0.6.sw,
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  radiusFactor: 1.2,
                  minimum: 10,
                  maximum: 40,
                  showLabels: false,
                  showTicks: true,
                  ranges: <GaugeRange>[
                    GaugeRange(
                        startValue: 10,
                        endValue: 16,
                        color: Colors.blue,
                        startWidth: 20,
                        endWidth: 20),
                    GaugeRange(
                        startValue: 16,
                        endValue: 18.5,
                        color: Colors.lightBlue,
                        startWidth: 20,
                        endWidth: 20),
                    GaugeRange(
                        startValue: 18.5,
                        endValue: 25,
                        color: Colors.green,
                        startWidth: 20,
                        endWidth: 20),
                    GaugeRange(
                        startValue: 25,
                        endValue: 30,
                        color: Colors.orange,
                        startWidth: 20,
                        endWidth: 20),
                    GaugeRange(
                        startValue: 30,
                        endValue: 40,
                        color: Colors.red,
                        startWidth: 20,
                        endWidth: 20),
                  ],
                  pointers: const <GaugePointer>[
                    NeedlePointer(
                      value: 22,
                      enableAnimation: true,
                      needleColor: Color(0xff4AAF57),
                      needleStartWidth: 5,
                      needleEndWidth: 11,
                      knobStyle: KnobStyle(
                        knobRadius: 0.115,
                        color: Color(0xff4AAF57),
                        borderWidth: 5,
                      ),
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      verticalAlignment: GaugeAlignment.near,
                      widget: Column(
                        children: <Widget>[
                          Text(
                            '22.0',
                            style: GoogleFonts.urbanist(
                                height: 1.4,
                                fontSize: 48.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "BMI (kg/m2)",
                            style: GoogleFonts.urbanist(
                                height: 1.6,
                                letterSpacing: 0.2,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp),
                          ),
                        ],
                      ),
                      angle: 90,
                      positionFactor: 0.5,
                      // ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      Column(
        children: [
          buildBMIItem(
            "very_severely_underweight".tr(),
            "BMI < 16.0",
            const Color(0xFF1A96F0),
          ),
          buildBMIItem(
            "severely_underweight".tr(),
            "BMI 16.0 - 16.9",
            const Color(0xFF00A9F1),
          ),
          buildBMIItem(
            "underweight".tr(),
            "BMI 17.0 - 18.4",
            const Color(0xFF00BCD3),
          ),
          buildBMIItem(
            "normal".tr(),
            "BMI 18.5 - 24.9",
            const Color(0xFF4AAF57),
          ),
          buildBMIItem(
            "overweight".tr(),
            "BMI 25.0 - 29.9",
            const Color(0xFFFFC02D),
          ),
          buildBMIItem(
            "obese_class_1".tr(),
            "BMI 30.0 - 34.9",
            const Color(0xFFFF981F),
          ),
          buildBMIItem(
            "obese_class_2".tr(),
            "BMI 35.0 - 39.9",
            const Color(0xFFFF5726),
          ),
          buildBMIItem(
            "obese_class_3".tr(),
            "BMI ≥ 40.0",
            const Color(0xFFF54336),
          ),
        ],
      ),

      ],
      ),
    );
  }
}
