
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildBMIItem(String category, String range, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            category.tr(),
            style: category != "normal".tr()
                ? GoogleFonts.urbanist(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    height: 1.6,
                    letterSpacing: 0.2,
                    color: const Color(0xFF616161),
                  )
                : GoogleFonts.urbanist(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    height: 1.6,
                    letterSpacing: 0.2,
                    color: const Color(0xFF212121)),
          ),
        ),
        Text(
          range,
          style: range != "BMI 18.5 - 24.9"
              ? GoogleFonts.urbanist(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  height: 1.6,
                  letterSpacing: 0.2,
                  color: const Color(0xFF616161),
                )
              : GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  height: 1.6,
                  letterSpacing: 0.2,
                  color: const Color(0xFF212121)),
        ),
      ],
    ),
  );
}
