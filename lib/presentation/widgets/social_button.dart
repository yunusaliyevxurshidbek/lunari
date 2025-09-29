import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialButton extends StatelessWidget {
  const SocialButton(
      {super.key,
      this.onClick,
      this.text,
      this.bgColor,
      this.color,
      this.borderRadius,
      this.width,
      this.height,
      this.icon});

  final Function()? onClick;
  final String? text;
  final Color? bgColor;
  final Color? color;
  final double? borderRadius;
  final double? width;
  final double? height;
  final String? icon;

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
                    border: Border.all(
                        width: 1, color: Colors.black.withOpacity(0.1)),
                    color: bgColor ?? Colors.white,
                    borderRadius: BorderRadius.circular(borderRadius ?? 30)),
                alignment: Alignment.center,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    if (icon != null)
                      Positioned(
                        left: 0,
                        right: text == null ? 0 : 0.6.sw,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            icon!,
                            height: 24,
                          ),
                        ),
                      ),
                    if (text != null)
                      Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 58,
                            alignment: Alignment.center,
                            child: Text(
                              text!.tr(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.urbanist(
                                  color: color ?? const Color(0xff212121),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                  ],
                ))));
  }
}
