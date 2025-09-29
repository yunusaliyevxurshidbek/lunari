import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';

class TermsServiceWidget extends StatefulWidget {
  const TermsServiceWidget({super.key});

  @override
  State<TermsServiceWidget> createState() => _TermsServiceWidgetState();
}

class _TermsServiceWidgetState extends State<TermsServiceWidget> {

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
                  'effective_date_text_2'.tr(),
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
                  'use_of_app'.tr(),
                  style: GoogleFonts.urbanist(
                    fontSize: 18.sp,
                    color: context.colors.scrim,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text("use_of_app_text".tr(),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'subscription'.tr(),
                  style: GoogleFonts.urbanist(
                    fontSize: 18.sp,
                    color: context.colors.scrim,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "subscription_text".tr(),
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