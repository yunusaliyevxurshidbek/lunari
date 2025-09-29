import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';

class FilterButtons extends StatefulWidget {
  const FilterButtons({Key? key}) : super(key: key);

  @override
  State<FilterButtons> createState() => _FilterButtonsState();
}

class _FilterButtonsState extends State<FilterButtons> {
  int selectedIndex = 0;
  final List<String> filters = ['all', 'period', 'ovulation', 'fertile'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 42.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final key = filters[index];
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => setState(() => selectedIndex = index),
            child: Container(
              height: 42.h,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFFF699C)
                    : context.colors.onPrimary,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: const Color(0xFFE0E0E0),
                  width: 1,
                ),
              ),
              child: Text(
                key.tr(),
                style: GoogleFonts.urbanist(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
      ),
    );
  }
}

