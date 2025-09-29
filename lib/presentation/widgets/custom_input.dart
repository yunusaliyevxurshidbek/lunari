import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  const CustomInput({super.key, this.controller,  this.onChanged, });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw - 48,
      height: 96,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: const Color(0xffeeeeee)),
        color: const Color(0xffFAFAFA)
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
              color: const Color(0xff212121),
                    fontSize: 32.sp, fontWeight: FontWeight.w700),
            decoration: InputDecoration(
                hintText: "Nickname".tr(),
                hintStyle: GoogleFonts.urbanist(
                    fontSize: 32.sp, fontWeight: FontWeight.w500),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none),
          ),
    );
  }
}
