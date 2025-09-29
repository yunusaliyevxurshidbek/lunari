import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.onClick,
      required this.text,
      this.bgColor,
      this.color,
      this.borderRadius,
      this.textSize,
      this.height,
      this.width});

  final Function()? onClick;
  final String text;
  final Color? bgColor;
  final Color? color;
  final double? borderRadius;
  final double? width;
  final double? height;
  final double? textSize;


  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: onClick,
          child: Container(
            width: width ?? 1.sw,
            height: height ?? 58,
            decoration: BoxDecoration(
                color: bgColor ?? Colors.white,
                borderRadius: BorderRadius.circular(borderRadius ?? 30)),
            alignment: Alignment.center,
            child: Text(
              text.tr(),
              style: GoogleFonts.urbanist(
                  color: color ?? const Color(0xff212121),
                  fontSize: textSize ?? 16.sp,
                  height: 1.6,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
