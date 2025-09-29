import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'expandable_container.dart';
import 'faq_filter.dart';

class FaqWidget extends StatefulWidget {
  const FaqWidget({super.key});

  @override
  State<FaqWidget> createState() => _FaqWidgetState();
}

class _FaqWidgetState extends State<FaqWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 15,
        children: [
      
          // search_field:
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: context.colors.onPrimary,
            ),
            child: Row(
              spacing: 5,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12.w, right: 8.w),
                  child: SvgPicture.asset(
                    "assets/icons/search.svg",
                    height: 25.h,
                    width: 25.w,
                    color: context.ccolors.textLight,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "search".tr(),
                      hintStyle: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp,
                        color: context.ccolors.textLight,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      
          // filter_buttons:
          const FaqFilterButtons(),
      
          // containers:
           ExpandableContainer(
             title: "what_is_lunari".tr(),
             info: "what_is_lunari_text".tr(),
           ),
           ExpandableContainer(
            title: "how_lunari_work".tr(),
            info: "how_lunari_work_text".tr(),
          ),
           ExpandableContainer(
            title: "is_lunari_free".tr(),
            info: "is_lunari_free_text".tr(),
          ),
           ExpandableContainer(
            title: "can_lunari_offline".tr(),
            info: "can_lunari_offline_text".tr(),
          ),
           ExpandableContainer(
            title: "is_my_data_secure".tr(),
            info: "is_my_data_secure_text".tr(),
          ),
           ExpandableContainer(
            title: "can_export_data".tr(),
            info: "can_export_data_text".tr(),
          ),
        ],
      ),
    );
}
}
