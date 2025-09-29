import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CircleWidget extends StatelessWidget {
  final String image;
  final String x;
  final String title;

  const CircleWidget({
    super.key,
    required this.image,
    required this.x,
    required this.title,
  });

  bool get isSvg => image.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              width: 1,
              color: const Color(0xFFEEEEEE),
            ),
          ),
          child: isSvg
              ? SvgPicture.asset(image)
              : Image.asset(image, fit: BoxFit.cover),
        ),
        Text(
          x.tr(),
          style: GoogleFonts.urbanist(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
          ),
        ),
        Text(
          title.tr(),
          style: GoogleFonts.urbanist(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: const Color(0xFF616161),
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
