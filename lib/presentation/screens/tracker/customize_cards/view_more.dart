import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget ViewMore() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          "view_more".tr(),
          style: GoogleFonts.urbanist(
            fontSize: 13.sp,
            color: const Color(0xFFFF699C),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.keyboard_arrow_down_sharp,
          size: 25,
          color: Color(0xFFFF699C),
        ),
      ),
    ],
  );

}