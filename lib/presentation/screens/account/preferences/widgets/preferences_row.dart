import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';
import '../../../../../data/models/perferences_model.dart';

class PreferenceRow extends StatelessWidget {
  final PreferenceItem item;
  const PreferenceRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Text(
          item.title.tr(),
          style: GoogleFonts.urbanist(
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            color: context.colors.scrim,
          ),
        ),
        const Spacer(),
        if (item.isSwitch) ...[
          Transform.scale(
            scale: 0.7,
            child: Switch(
              value: item.switchValue ?? false,
              onChanged: item.onSwitchChanged,
              activeColor: context.colors.onPrimary,
              activeTrackColor: context.colors.primary,
            ),
          ),
        ] else ...[
          if (item.value != null)
            Text(
              item.value!.tr(),
              style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: context.colors.scrim,
              ),
            ),
          if (item.hasBottomSheet)
            SvgPicture.asset(
              "assets/icons/arrow_right.svg",
              height: 20,
              width: 20,
              color: context.colors.scrim,
            ),
        ],
      ],
    );
  }
}