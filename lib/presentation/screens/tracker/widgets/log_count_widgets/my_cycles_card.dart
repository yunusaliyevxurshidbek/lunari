import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';

import '../../customize_cards/custom_card.dart';
import '../../cycles_page.dart';

class MyCyclesCard extends StatelessWidget {
  const MyCyclesCard({super.key});

  callCyclesPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyCyclesPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callCyclesPage(context);
      },
      child: CustomCard(
        child: Column(
          spacing: 10,
          children: [
            // Firts Row:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "my_cycles".tr(),
                  style: GoogleFonts.urbanist(
                    color: const Color(0xff212121),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SvgPicture.asset(
                  "assets/icons/arrow_right.svg",
                  width: 20,
                  height: 20,
                  colorFilter:
                  const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                ),
              ],
            ),

            // Second row:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 12,
              children: [
                // 1:
                Container(
                  width: 0.5.sw - 50,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: context.colors.onSecondary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            spacing:4,
                            children: [
                              Text(
                                "4",
                                style: GoogleFonts.urbanist(
                                  color: const Color(0xFF212121),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "days".tr(),
                                style: GoogleFonts.urbanist(
                                  color: const Color(0xFF212121),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "average_period".tr(),
                            style: GoogleFonts.urbanist(
                              fontSize: 11.sp,
                              color: const Color(0xFF616161),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SvgPicture.asset(
                        "assets/icons/blood.svg",
                        width: 25,
                        height: 25,
                      ),
                    ],
                  ),
                ),

                // 2:
                Container(
                  width: 0.5.sw - 50,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            spacing:4,
                            children: [
                              Text(
                                "28",
                                style: GoogleFonts.urbanist(
                                  color: const Color(0xFF212121),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "days".tr(),
                                style: GoogleFonts.urbanist(
                                  color: const Color(0xFF212121),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "average_cycle".tr(),
                            style: GoogleFonts.urbanist(
                              fontSize: 11.sp,
                              color: const Color(0xFF616161),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const Image(
                        image: AssetImage("assets/images/calendar_spiral.png",),
                        height: 30,
                        width: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
