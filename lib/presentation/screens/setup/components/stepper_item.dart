import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunari/core/utils/context_extention.dart';

class StepperItem extends StatelessWidget {
  const StepperItem(
      {super.key, required this.selectedDay, required this.onChanged});

  final int selectedDay;
  final Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      scrollController: FixedExtentScrollController(initialItem: selectedDay),
      itemExtent: 100,
      onSelectedItemChanged: (index) {
        // setState(() {
        //   selectedDay = index;
        // });
      },
      selectionOverlay: Container(
        height: 100,
        decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(width: 1, color: Color(0xffFF699C)),
                bottom: BorderSide(width: 1, color: Color(0xffFF699C)))),
      ),
      children: List.generate(31, (index) {
        return Center(
          child: Text(
            "${index + 1}".padLeft(2, '0').tr(),
            style: TextStyle(
              fontSize: selectedDay == index ? 48.sp : 40.sp,
              height: 1.4,
              color: selectedDay == index
                  ? context.colors.primary
                  : const Color(0xff424242),
              fontWeight:
                  selectedDay == index ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        );
      }),
    );
  }
}
