import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/menstrual_cycle_phases.dart';
import 'info_item.dart';

class InfoPanel extends StatelessWidget {
  const InfoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
          color: const Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(width: 1, color: const Color(0xffFFFFFF))),
      child: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(bottom: 20, top: 16, right: 16, left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "mentstrual_cycle_phases".tr(),
                  style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      height: 1.4,
                      color: const Color(0xff212121)),
                ),
                InkWell(
                  onTap: () {
                    context.push("/phase_detail");
                  },
                  child: SvgPicture.asset("assets/icons/arrow_right.svg"),
                )
              ],
            ),
          ),
          SizedBox(
            width: 1.sw,
            height: 150,
            child: ListView.separated(
                itemCount: menstrualCyclePhases.length,
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InfoItem(
                    item: menstrualCyclePhases[index],
                    index: index,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 12),),
          )
        ],
      ),
    );
  }
}
