import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';

class PrivacyPolicyWidget extends StatefulWidget {
  const PrivacyPolicyWidget({super.key});

  @override
  State<PrivacyPolicyWidget> createState() => _PrivacyPolicyWidgetState();
}

class _PrivacyPolicyWidgetState extends State<PrivacyPolicyWidget> {


  @override
  Widget build(BuildContext context) {
    return ListView(
    children: [
      Column(
        spacing: 15,
        children: [
          Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'effective_date'.tr(),
                style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  color: context.colors.scrim,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'effective_date_text'.tr(),
                style: GoogleFonts.urbanist(
                  fontSize: 15.sp,
                  color: context.colors.greyScale,
                  fontWeight: FontWeight.w500,
                ),

              ),
            ],
          ),

          // 1:
          Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'information_we_collect'.tr(),
                style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  color: context.colors.scrim,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text("information_we_collect_text".tr(),
                style: GoogleFonts.urbanist(
                  fontSize: 15.sp,
                  color: context.ccolors.greyScale,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          // 2:
          Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'how_use_your_information'.tr(),
                style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  color: context.colors.scrim,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text("how_use_your_information_text".tr(),
                style: GoogleFonts.urbanist(
                  fontSize: 15.sp,
                  color: context.ccolors.greyScale,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

        ],
      ),
    ],
          );
  }
}