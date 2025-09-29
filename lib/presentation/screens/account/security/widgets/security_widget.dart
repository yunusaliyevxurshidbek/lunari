import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';

class SecurityWidget extends StatefulWidget {
  const SecurityWidget({super.key});

  @override
  State<SecurityWidget> createState() => _SecurityWidgetState();
}

class _SecurityWidgetState extends State<SecurityWidget> {
  bool biometric = false;
  bool face = false;
  bool sms = false;
  bool google = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.colors.onPrimary,
      ),
      child: Column(
        spacing: 15,
        children: [
          // 1:
          Row(
            children: [
              Text("biometric_id".tr(),style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                color: context.colors.scrim,
              ),),
              const Spacer(),
              Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: biometric,
                  onChanged: (value) {
                    setState(() {
                      biometric = value;
                    });
                  },
                  activeColor: context.colors.onPrimary,
                  activeTrackColor: context.colors.primary,
                ),
              ),
            ],
          ),

          // 2:
          Row(
            children: [
              Text("face_id".tr(),style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                color: context.colors.scrim,
              ),),
              const Spacer(),
              Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: face,
                  onChanged: (value) {
                    setState(() {
                      face = value;
                    });
                  },
                  activeColor: context.colors.onPrimary,
                  activeTrackColor: context.colors.primary,
                ),
              ),
            ],
          ),

          // 3:
          Row(
            children: [
              Text("sms_authenticator".tr(),style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                color: context.colors.scrim,
              ),),
              const Spacer(),
              Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: sms,
                  onChanged: (value) {
                    setState(() {
                      sms = value;
                    });
                  },
                  activeColor: context.colors.onPrimary,
                  activeTrackColor: context.colors.primary,
                ),
              ),
            ],
          ),

          // 4:
          Row(
            children: [
              Text("google_auth".tr(),style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                color: context.colors.scrim,
              ),),
              const Spacer(),
              Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: google,
                  onChanged: (value) {
                    setState(() {
                      google = value;
                    });
                  },
                  activeColor: context.colors.onPrimary,
                  activeTrackColor: context.colors.primary,
                ),
              ),
            ],
          ),

          // 5:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("change_password".tr(),style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
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

          // 6:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("device_management".tr(),style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: context.colors.scrim,
                  ),),
                  const Spacer(),
                  SvgPicture.asset(
                    "assets/icons/arrow_right.svg",
                    height: 20,
                    width: 20,
                    color: context.colors.scrim,
                  )
                ],
              ),
              Text("device_management_text.".tr(),style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w400,
                color: context.ccolors.greyScale700,
                fontSize: 15.sp,
              ),)
            ],
          ),

          // 7:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("deactivate_account".tr(),style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: context.colors.scrim,
                  ),),
                  const Spacer(),
                  SvgPicture.asset(
                    "assets/icons/arrow_right.svg",
                    height: 20,
                    width: 20,
                    color: context.colors.scrim,
                  )
                ],
              ),
              Text("deactivate_account_text".tr(),style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w400,
                color: context.ccolors.greyScale700,
                fontSize: 15.sp,
              ),)
            ],
          ),

          // 8:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("delete_account".tr(),style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: context.colors.error,
                  ),),
                  const Spacer(),
                  SvgPicture.asset(
                    "assets/icons/arrow_right.svg",
                    height: 20,
                    width: 20,
                    color: context.colors.scrim,
                  )
                ],
              ),
              Text("delete_account_text".tr(),style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w400,
                color: context.ccolors.greyScale700,
                fontSize: 15.sp,
              ),)
            ],
          ),
        ],
      ),
    );
  }
}
