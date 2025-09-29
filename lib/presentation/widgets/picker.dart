import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';

class DataPicker extends StatefulWidget {
  const DataPicker({super.key, required this.maxNumber, required this.number});

  final int maxNumber;
  final int number;


  @override
  State<DataPicker> createState() => _DataPickerState();
}

class _DataPickerState extends State<DataPicker> {
  late int selectedYear;

  @override
  void initState() {
    super.initState();
    selectedYear = widget.maxNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CupertinoPicker(
        scrollController:
        FixedExtentScrollController(initialItem: selectedYear),
        itemExtent: 60,
        onSelectedItemChanged: (index) {
          setState(() {
            selectedYear = index;
          });
        },
        children: List.generate(widget.number, (index) {
          int year = selectedYear + index;
          return Center(
            child: Text(
              "$year".tr(),
              style: GoogleFonts.urbanist(
                fontSize: selectedYear == index ? 24 : 16,
                color: selectedYear == index
                    ? context.colors.primary
                    : Colors.black.withOpacity(0.8),
                fontWeight: selectedYear == index
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          );
        }),
      ),
    )
    ;
  }
}
