import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';

class AnalyticWidget extends StatefulWidget {
  const AnalyticWidget({super.key});

  @override
  State<AnalyticWidget> createState() => _AnalyticWidgetState();
}

class _AnalyticWidgetState extends State<AnalyticWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.colors.onPrimary,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        children: [
          // 1:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "data_usage".tr(),
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      color: context.colors.scrim,
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    "assets/icons/arrow_right.svg",
                    height: 20,
                    width: 20,
                    color: context.colors.scrim,
                  )
                ],
              ),
              Text(
                "control_data".tr(),
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w400,
                  color: context.ccolors.greyScale700,
                  fontSize: 15.sp,
                ),
              )
            ],
          ),

          // 2:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "add_preferences".tr(),
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      color: context.colors.scrim,
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    "assets/icons/arrow_right.svg",
                    height: 20,
                    width: 20,
                    color: context.colors.scrim,
                  )
                ],
              ),
              Text(
                "add_preferences_text".tr(),
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w400,
                  color: context.ccolors.greyScale700,
                  fontSize: 15.sp,
                ),
              )
            ],
          ),

          // 3:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "download_my_data".tr(),
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      color: context.colors.scrim,
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    "assets/icons/arrow_right.svg",
                    height: 20,
                    width: 20,
                    color: context.colors.scrim,
                  )
                ],
              ),
              Text(
                "download_my_data_text".tr(),
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w400,
                  color: context.ccolors.greyScale700,
                  fontSize: 15.sp,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
