import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';
import '../../../../../data/models/perferences_model.dart';

class PreferenceBottomSheet extends StatelessWidget {
  final BottomSheetConfig config;
  const PreferenceBottomSheet({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.onPrimary,
        borderRadius:  BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: context.colors.scrim.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // title:
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              config.title.tr(),
              style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w700,
                fontSize: 22.sp,
                color: context.colors.scrim,
              ),
            ),
          ),

          ...config.options.map((option) => _buildOption(context, option)),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, BottomSheetOption option) {
    final isSelected = option.value == config.currentValue;

    return InkWell(
      onTap: () {
        config.onSelected(option.value);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Text(
              option.title.tr(),
              style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: context.colors.scrim,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check,
                color: context.colors.primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
