import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';

class ChoiceDay extends StatelessWidget {
  const ChoiceDay({
    super.key,
    required this.text,
    required this.second,
    required this.isSelected,
    required this.isToday,
    required this.primaryColor,
    required this.secondaryColor,
  });

  final String text;
  final String second;
  final bool isSelected;
  final bool isToday;
  final Color primaryColor;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    final label = isToday ? 'Today' : text.tr();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.urbanist(
              fontSize: 14.sp,
              color: context.colors.onPrimaryContainer,
            ),
          ),
        ),
        SizedBox(
          height: 38,
          width: 38,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: isSelected ? primaryColor : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                width: isSelected ? 0 : 2,
                color: context.ccolors.dividerLight,
              ),
            ),
            child: Center(
              child: Text(
                second,
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? secondaryColor
                      : context.colors.onPrimaryContainer,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
