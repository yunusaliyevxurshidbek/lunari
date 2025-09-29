import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';

class UpgradeText extends StatelessWidget {
  const UpgradeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        //1:
        Row(
          spacing: 10,
          children: [
            SvgPicture.asset(
              "assets/icons/confirm.svg",
              height: 20,
              width: 20,
            ),
            Text("add_free_experience".tr(),style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              color: context.colors.scrim,
            ),)
          ],
        ),

        //2:
        Row(
          spacing: 10,
          children: [
            SvgPicture.asset(
              "assets/icons/confirm.svg",
              height: 20,
              width: 20,
            ),
            Text("advanced_period".tr(),style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              color: context.colors.scrim,
            ),)
          ],
        ),

        //3:
        Row(
          spacing: 10,
          children: [
            SvgPicture.asset(
              "assets/icons/confirm.svg",
              height: 20,
              width: 20,
            ),
            Text("detailed_data".tr(),style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              color: context.colors.scrim,
            ),)
          ],
        ),

        //4:
        Row(
          spacing: 10,
          children: [
            SvgPicture.asset(
              "assets/icons/confirm.svg",
              height: 20,
              width: 20,
            ),
            Text("Unlock exclusive contents.".tr(),style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              color: context.colors.scrim,
            ),)
          ],
        ),

        //5:
        Row(
          spacing: 10,
          children: [
            SvgPicture.asset(
              "assets/icons/confirm.svg",
              height: 20,
              width: 20,
            ),
            Text("priority_customer".tr(),style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              color: context.colors.scrim,
            ),)
          ],
        ),

        //6:
        Row(
          spacing: 10,
          children: [
            SvgPicture.asset(
              "assets/icons/confirm.svg",
              height: 20,
              width: 20,
            ),
            Text("early_access".tr(),style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              color: context.colors.scrim,
            ),)
          ],
        ),
      ],
    );
  }
}
