import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';

class FaqFilterButtons extends StatefulWidget {
  const FaqFilterButtons({super.key});

  @override
  State<FaqFilterButtons> createState() => _FaqFilterButtonsState();
}

class _FaqFilterButtonsState extends State<FaqFilterButtons> {
  int selectedIndex = 0;
  final List<String> filters = ['general', 'account', 'services', 'tracker'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 42,
      child: ListView.separated(
          itemCount: filters.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final filter = filters[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                height: 42,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? context.colors.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: selectedIndex == index
                        ? Colors.transparent
                        : context.colors.surfaceDim,
                    width: 1,
                  ),
                ),
                child: Text(
                  filter.tr(),
                  style: GoogleFonts.urbanist(
                    color: selectedIndex == index ? context.colors.onPrimary : context.colors.scrim,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            width: 12,
          )),
    );
  }
}
