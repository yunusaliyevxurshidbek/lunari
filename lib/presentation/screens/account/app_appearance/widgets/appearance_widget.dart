import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';
import '../language.dart';
import 'theme_bottom_sheet.dart';

class AppearanceWidget extends StatefulWidget {
  const AppearanceWidget({super.key});

  @override
  State<AppearanceWidget> createState() => _AppearanceWidgetState();
}

class _AppearanceWidgetState extends State<AppearanceWidget> {

  callLanguageList(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Language()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        spacing: 20,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.colors.onPrimary,
            ),
            child: Column(
              spacing: 15,
              children: [
                // 1:
                InkWell(
                  onTap: (){
                    ThemeBottomSheet.show(context);

                  },
                  child: Container(
                    child: Row(
                      spacing: 10,
                      children: [
                        Text("theme".tr(),style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                          color: context.colors.scrim,
                        ),),
                        const Spacer(),
                        Text("light".tr(),style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          color: context.colors.scrim,
                        ),),
                        SvgPicture.asset(
                          "assets/icons/arrow_right.svg",
                          height: 20,
                          width: 20,
                          color: context.colors.scrim,
                        )
                      ],
                    ),
                  ),
                ),

                // 2:
                InkWell(
                  onTap: (){
                    callLanguageList();
                  },
                  child: Container(
                    child: Row(
                      spacing: 10,
                      children: [
                        Text("app_language".tr(),style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                          color: context.colors.scrim,
                        ),),
                        const Spacer(),
                        Text("English",style: GoogleFonts.urbanist(        // tr() no need:
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          color: context.colors.scrim,
                        ),),
                        SvgPicture.asset(
                          "assets/icons/arrow_right.svg",
                          height: 20,
                          width: 20,
                          color: context.colors.scrim,
                        )
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
