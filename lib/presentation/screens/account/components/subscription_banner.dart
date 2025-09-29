import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../upgrade_plan/pages/upgrade_plan.dart';

class SubscriptionBanner extends StatelessWidget {
  const SubscriptionBanner({super.key});

  callUpgradePlanPage(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UpgradePlan()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        callUpgradePlanPage(context);
      },
      child: Container(
        width: 1.sw - 48,
        padding: const EdgeInsets.only(top: 12, left: 12, bottom: 12, right: 16),
        decoration: BoxDecoration(
            color: const Color(0xffFF699C),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              "assets/icons/banner_back.svg",
              height: 60,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "upgrade_plan_now".tr(),
                    style: GoogleFonts.urbanist(
                        fontSize: 18.sp,
                        color: const Color(0xffFFFFFF),
                        height: 1.4,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      "upgrade_plan_now_text_1".tr(),
                      style: GoogleFonts.urbanist(
                          height: 1.6,
                          letterSpacing: 0.2,
                          fontSize: 12.sp,
                          color: const Color(0xffFFFFFF)),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
