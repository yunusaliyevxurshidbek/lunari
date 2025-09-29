import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/screens/account/upgrade_plan/pages/payment_page.dart';
import '../widgets/upgrade_text.dart';

class Yearly extends StatefulWidget {
  const Yearly({super.key});

  @override
  State<Yearly> createState() => _YearlyState();
}

class _YearlyState extends State<Yearly> {

  callPaymentPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PaymentPage()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: context.colors.onPrimary,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1, color: context.colors.onPrimary),
                ),
                child: Column(
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
                                r"$49.99 / ",
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
                    spacing: 5,
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
                        "16%".tr(),
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
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            color: context.colors.onPrimary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    callPaymentPage();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      color: context.colors.primary,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "continue".tr(),
                          style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w700,
                            color: context.colors.onPrimary,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          r" - $49.99".tr(),
                          style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w700,
                            color: context.colors.onPrimary,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
