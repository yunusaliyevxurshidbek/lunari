import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/core/constants/app_icons.dart';
import 'day_name.dart';

class SelectData extends StatelessWidget {
  final List<DateTime>? dates;
  final List<DateTime>? selectedDates;
  final Function(DateTime)? onDateSelected;
  final bool Function(DateTime)? isSelectable;

  const SelectData({
    this.dates,
    super.key,
    this.selectedDates,
    this.onDateSelected,
    this.isSelectable,
  });

  @override
  Widget build(BuildContext context) {
    if (dates == null || dates!.isEmpty) return const SizedBox.shrink();

    List<Widget> gridItems = [];
    int firstDayOffset = (dates!.first.weekday % 7);

    gridItems = List.generate(
      firstDayOffset,
          (index) => const SizedBox.shrink(),
    );

    gridItems.addAll(
      dates!.map((date) {
        bool isSelected = selectedDates?.contains(date) ?? false;
        bool selectable = isSelectable?.call(date) ?? true;

        return GestureDetector(
          onTap: selectable ? () => onDateSelected!(date) : null,


          child: Column(
            children: [
              Text(
                '${date.day}'.tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? context.colors.primary
                      : context.colors.onPrimaryContainer,
                ),
              ),
              SvgPicture.asset(
                isSelected ? AppIcons.selected : AppIcons.unSelected,
                height: 20,
                fit: BoxFit.contain,
              ),
            ],
          ),
        );
      }).toList(),
    );

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              dates != null && dates!.isNotEmpty
                  ? DateFormat.MMMM().format(DateTime(dates!.first.year, dates!.first.month, 1))
                  : '',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(10.0), child: Divider()),
          const DayNames(),
          const SizedBox(height: 8),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 7,
            mainAxisSpacing: 8,
            children: gridItems,
          ),
        ],
      ),
    );
  }
}
