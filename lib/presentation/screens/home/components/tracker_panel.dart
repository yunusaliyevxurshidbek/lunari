import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'circular_progress_painter.dart';

class TrackerPanel extends StatelessWidget {
  final int currentDayNumber;
  final int totalDaysForContext;
  final bool isInPeriod;
  final int ovulationDaysLeft;
  final VoidCallback onEdit;

  const TrackerPanel({
    Key? key,
    required this.currentDayNumber,
    required this.totalDaysForContext,
    required this.isInPeriod,
    required this.ovulationDaysLeft,
    required this.onEdit,
  }) : super(key: key);

  String _getOrdinalSuffix(int number) {
    final mod100 = number % 100;
    if (mod100 >= 11 && mod100 <= 13) return 'th';

    switch (number % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }


  @override
  Widget build(BuildContext context) {
    final suffix = _getOrdinalSuffix(currentDayNumber);
    return Container(
      width: 1.sw,
      height: 440,
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 320,
              height: 320,
              child: CustomPaint(
                painter: CircularProgressPainter(
                  selectedDaysCount: currentDayNumber,
                  totalDays: totalDaysForContext,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/blood.svg',
                        color: isInPeriod ? context.colors.primary : context.ccolors.greyScale600,
                      ),

                      SizedBox(height: 4.h),

                      Text(
                        isInPeriod ? 'period'.tr() : 'cycle'.tr(),
                        style: GoogleFonts.urbanist(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                          color: context.ccolors.greyScale600,
                        ),
                      ),


                      SizedBox(height: 8.h),

                      RichText(
                        text: TextSpan(
                          text: '$currentDayNumber$suffix',
                          style: TextStyle(
                            fontSize: 40.sp,
                            fontWeight: FontWeight.w600,
                            color: context.ccolors.scrim,
                          ),
                          children: [
                            TextSpan(
                              text: ' days'.tr(),
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal,
                                color: context.ccolors.greyScale600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 8.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ovulation'.tr(),
                            style: GoogleFonts.urbanist(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: context.ccolors.greyScale600,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '$ovulationDaysLeft',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: context.ccolors.greyScale600,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'days_left'.tr(),
                            style: GoogleFonts.urbanist(
                                fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: context.ccolors.greyScale600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: onEdit,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
                    backgroundColor: context.colors.primary
                ),
                child: Text(
                  'edit_period'.tr(),
                  style: GoogleFonts.urbanist(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
