import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeekDayItem extends StatelessWidget {
  const WeekDayItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Sun".tr(),
      style: GoogleFonts.urbanist(
          fontSize: 24.sp,
          color: const Color(0xff212121),
          height: 1.4,
          fontWeight: FontWeight.bold),
    );
  }
}
