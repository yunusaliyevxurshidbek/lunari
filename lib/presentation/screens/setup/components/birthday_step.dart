import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';

import '../../../blocs/setup/setup_bloc.dart';
import '../../../blocs/setup/setup_event.dart';

class BirthdayStep extends StatefulWidget {
  const BirthdayStep({super.key});

  @override
  State<BirthdayStep> createState() => _BirthdayStepState();
}

class _BirthdayStepState extends State<BirthdayStep> {
  late int selectedMonth;
  late int selectedDay;
  late int selectedYear;
  late FixedExtentScrollController yearController;

  @override
  void initState() {
    super.initState();
    selectedMonth = 1;
    selectedDay = 1;
    selectedYear = 2000;
    yearController = FixedExtentScrollController(initialItem: selectedYear - 1926);
  }

  void _updateBirthday() {
    String birthday = "$selectedYear-${selectedMonth.toString().padLeft(2, '0')}-${selectedDay.toString().padLeft(2, '0')}";
    context.read<SetupBloc>().add(BirthdayChanged(birthday));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 0.7.sh,
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "your_birthday".tr(),
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
              color: const Color(0xff212121),
              fontSize: 32.sp,
              height: 1.4,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPickerLabel("day".tr()),
                      _buildPickerLabel("month".tr()),
                      _buildPickerLabel("Year".tr()),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCupertinoPicker(31, selectedDay - 1, (index) {
                        setState(() => selectedDay = index + 1);
                        _updateBirthday();
                      }),
                      _buildCupertinoPicker(12, selectedMonth - 1, (index) {
                        setState(() => selectedMonth = index + 1);
                        _updateBirthday();
                      }),
                      _buildCupertinoPicker(100, selectedYear - 1926, (index) {
                        setState(() => selectedYear = 1926 + index);
                        _updateBirthday();
                      }, yearController),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPickerLabel(String text) {
    return Expanded(
      child: Text(
        text.tr(),
        textAlign: TextAlign.center,
        style: GoogleFonts.urbanist(
          color: const Color(0xff757575),
          height: 1.4,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCupertinoPicker(int itemCount, int initialItem, Function(int) onSelected, [FixedExtentScrollController? controller]) {
    return Expanded(
      child: CupertinoPicker(
        scrollController: controller ?? FixedExtentScrollController(initialItem: initialItem),
        itemExtent: 100,
        onSelectedItemChanged: onSelected,
        selectionOverlay: Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1, color: context.colors.primary),
              bottom: BorderSide(width: 1, color: context.colors.primary),
            ),
          ),
        ),
        children: List.generate(itemCount, (index) {
          int value = controller == yearController ? 1926 + index : index + 1;
          bool isSelected = value == (controller == yearController ? selectedYear : controller == null ? selectedDay : selectedMonth);
          return Center(
            child: Text(
              "$value".padLeft(2, '0').tr(),
              style: TextStyle(
                fontSize: isSelected ? 48.sp : 40.sp,
                height: 1.4,
                color: isSelected ? context.colors.primary : const Color(0xff424242),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              ),
            ),
          );
        }),
      ),
    );
  }
}
