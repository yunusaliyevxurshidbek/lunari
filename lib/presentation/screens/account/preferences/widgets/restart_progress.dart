import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';

class RestartProgressBottomshet extends StatefulWidget {
  const RestartProgressBottomshet({super.key});
  
  @override
  _RestartProgressBottomshetState createState() => _RestartProgressBottomshetState();
}

class _RestartProgressBottomshetState extends State<RestartProgressBottomshet> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 24, left: 24, top: 15, bottom: 36),
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('restart_all_progress'.tr(),
              style: GoogleFonts.urbanist(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: context.colors.alert,
              )),

          Divider(
            thickness: 1,
            color: context.colors.dividerLight,
          ),

          Text('restart_all_progress_text'.tr(),
              style: GoogleFonts.urbanist(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: context.colors.scrim,
              )),

          Divider(
            thickness: 1,
            color: context.colors.dividerLight,
          ),


          // buttons:
          Row(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: context.colors.secondary,
                    ),
                    child: Text('cancel'.tr(),
                        style: GoogleFonts.urbanist(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: context.colors.primary,
                        )),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: context.colors.primary,
                    ),
                    child: Text('ok'.tr(),
                        style: GoogleFonts.urbanist(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: context.colors.onPrimary,
                        )),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}