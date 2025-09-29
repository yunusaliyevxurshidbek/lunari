import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import '../upgrade_plan/widgets/upgrade_text.dart';

class AboutSubscription extends StatefulWidget {
  const AboutSubscription({super.key});

  @override
  State<AboutSubscription> createState() => _AboutSubscriptionState();
}

class _AboutSubscriptionState extends State<AboutSubscription> {

  callAccountPage() {
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.secondary,
      appBar: AppBar(
        backgroundColor: context.colors.secondary,
        title: Text(
          "billing_subscription".tr(),
          style: GoogleFonts.urbanist(
              fontSize: 24.sp,
              color: const Color(0xff212121),
              height: 1.4,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24, top: 15, bottom: 15),
          child: GestureDetector(
            onTap: () {
              callAccountPage();
            },
            child: SvgPicture.asset(
              "assets/icons/arrow_left_long.svg",
              height: 28,
              width: 28,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 8),
        child: Column(
          spacing: 15,
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: context.colors.onPrimary,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1, color: context.colors.onPrimary),
                  ),
                  child: Column(
                    spacing: 15,
                    children: [
                      Column(
                        spacing: 10,
                        children: [
                          Text(
                            "lunari_pro".tr(),
                            style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.sp,
                              color: context.colors.scrim,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  r"$49.99 /",
                                  style: GoogleFonts.urbanist(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30.sp,
                                    color: context.colors.scrim,
                                  ),
                                ),
                                Text(
                                  "year".tr(),
                                  style: GoogleFonts.urbanist(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.sp,
                                    color: context.colors.scrim,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 1,
                            color: context.ccolors.dividerLight,
                          ),
                          const UpgradeText(),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        color: context.ccolors.dividerLight,
                      ),
                      Text("your_current_plan".tr(),style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w600,
                        color: context.ccolors.greyScale700,
                        fontSize: 16.sp,
                      ),)

                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 65,
                    height: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: context.colors.primary,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      spacing: 4,
                      children: [
                        Text(
                          "save".tr(),
                          style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: context.colors.onPrimary,
                          ),
                        ),
                        Text(
                          "16%",
                          style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: context.colors.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "subscription_expire\n".tr(),
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w400,
                      color: context.colors.greyScale700,
                      fontSize: 15.sp,
                    ),
                  ),
                  TextSpan(
                    text: "renew_cancel".tr(),
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w400,
                      color: context.colors.greyScale700,
                      fontSize: 15.sp,
                    ),
                  ),
                  TextSpan(
                    text: "here".tr(),
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w400,
                      color: context.colors.primary,
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            )
            

          ],
        ),
      ),
    );
  }
}
