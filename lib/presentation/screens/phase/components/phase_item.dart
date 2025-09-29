import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunari/core/utils/context_extention.dart';

class PhaseItem extends StatelessWidget {
  const PhaseItem(
      {super.key, required this.title, required this.description, this.level});

  final String title;
  final String description;
  final int? level;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: 1.sw - 48,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
          color: context.colors.onPrimary,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.urbanist(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                    color: const Color(0xff212121)),
              ),
              const SizedBox(
                width: 6,
              ),
              if (level != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: level == 1
                          ? const Color(0xff607D8A)
                          : level == 2
                              ? const Color(0xffFF981F)
                              : const Color(0xffFF699C)),
                  child: Text(
                    level == 1
                        ? "Low"
                        : level == 2
                            ? "Medium"
                            : "High",
                    style: GoogleFonts.urbanist(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                        letterSpacing: 0.2,
                        color:  context.colors.onPrimary),
                  ),
                )
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            description,
            style: GoogleFonts.urbanist(
                fontSize: 18.sp,
                height: 1.6,
                letterSpacing: 0.2,
                color: const Color(0xff424242)),
          ),
        ],
      ),
    );
  }
}
