import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';

class ContactSupportWidget extends StatefulWidget {
  final icon;
  final title;
  const ContactSupportWidget({super.key, this.icon, this.title});

  @override
  State<ContactSupportWidget> createState() => _ContactSupportWidgetState();
}

class _ContactSupportWidgetState extends State<ContactSupportWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.colors.onPrimary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Row(
            spacing: 10,
            children: [
              SvgPicture.asset(
                widget.icon,
                height: 25.h,
                width: 25.w,
                color: context.colors.primary,
              ),

              Text(widget.title.tr(),style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w700,
                color: context.colors.scrim,
                fontSize: 18.sp,
              ),),
            ],
          ),


          SvgPicture.asset(
            "assets/icons/arrow_right.svg",
            height: 25.h,
            width: 25.w,
            color: context.colors.scrim,
          ),

        ],
      ),
    );
  }
}
