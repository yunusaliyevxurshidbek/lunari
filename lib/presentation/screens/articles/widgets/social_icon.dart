import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';
import '../../../../data/models/user_model.dart';

class SocialIcon extends StatelessWidget {
  final SocialPlatform platform;

  const SocialIcon(this.platform, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: 55.w,
              maxHeight: 55.w,
              minWidth: 45.w,
              minHeight: 45.w,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Image.asset(
              platform.icon,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            platform.name.tr(),
            style: GoogleFonts.urbanist(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: context.colors.scrim,
            ),
          ),
        ],
      ),
    );
  }
}