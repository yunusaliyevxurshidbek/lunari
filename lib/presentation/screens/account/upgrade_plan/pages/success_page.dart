
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';

import '../widgets/confetti_widget.dart';
import '../widgets/upgrade_text.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24,right: 24,top: 60,bottom: 10),
      color: context.colors.onPrimary,
      child: Stack(
        children:[
          SingleChildScrollView(
          child: Column(
            spacing: 10,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFF981F),     // exception:
                ),
                child: ClipOval(
                  child: SvgPicture.asset(
                    'assets/icons/crown.svg',
                  ),
                ),
              ),
              Text("congratulations".tr(),style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w700,
                color: context.colors.scrim,
                fontSize: 25.sp,
              ),),
              Text("unlocked_one_year_pro".tr(),style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w400,
                fontSize: 15.sp,
                color: context.ccolors.greyScale,
              ),),

              const SizedBox(height: 15,),
              Text("benefits_unlocked".tr(),style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w700,
                color: context.colors.scrim,
                fontSize: 18.sp,
              ),),
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: UpgradeText(),
              ),

              Divider(
                thickness: 1,
                color: context.colors.dividerLight,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("automatically_renew".tr(),style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w500,
                    color: context.ccolors.greyScale,
                    fontSize: 15.sp,
                    height: 1.5,
                  ),),
                ],
              ),
            ],
          ),
        ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: context.colors.onPrimary,
              child: GestureDetector(
                onTap: () {
                  // TODO:
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: context.colors.primary,
                  ),
                  child: Text(
                    "start_exploring_features".tr(),
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w700,
                      color: context.colors.onPrimary,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const ConfettiWidgetCustom(),

        ],
      ),
    );
  }
}
