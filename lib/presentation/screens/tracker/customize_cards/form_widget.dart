import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget FormWidget({
  required String image,
  required String x,
  required String title,
}) {
  return Column(
    children: [
      Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Image(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      Text(
        x.tr(),
        style: GoogleFonts.urbanist(
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
        ),
      ),
      SizedBox(
        width: 70,
        child: Text(
          title.tr(),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: true,
          style: GoogleFonts.urbanist(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: const Color(0xFF616161),
          ),
        ),
      ),
    ],
  );
}