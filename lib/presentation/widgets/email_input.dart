import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailInput extends StatelessWidget {
  final TextEditingController? controller;
  const EmailInput({super.key, this.title, required this.onChanged, this.controller});
  final String? title;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title?.tr() ?? "Email".tr(),
          style: GoogleFonts.urbanist(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xfffafafa),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            textAlignVertical: TextAlignVertical.center,
            onChanged: onChanged,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 10, top: 15, bottom: 15),
                child: SvgPicture.asset(
                  "assets/icons/email.svg",
                  height: 20,
                ),
              ),
              hintText: "Email".tr(),
              hintStyle: GoogleFonts.urbanist(fontSize: 18.sp, fontWeight: FontWeight.w500),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }
}
