import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';

import '../../../blocs/setup/setup_bloc.dart';
import '../../../blocs/setup/setup_event.dart';

class CycleStep extends StatefulWidget {
  const CycleStep({super.key});

  @override
  State<CycleStep> createState() => _CycleStepState();
}

class _CycleStepState extends State<CycleStep> {
  late FixedExtentScrollController _day1Controller;
  late FixedExtentScrollController _day2Controller;

  @override
  void initState() {
    super.initState();
    final setupBloc = context.read<SetupBloc>().state;
    _day1Controller = FixedExtentScrollController(initialItem: setupBloc.cycleMin);
    _day2Controller = FixedExtentScrollController(initialItem: setupBloc.cycleMax);
  }

  @override
  void dispose() {
    _day1Controller.dispose();
    _day2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final setupBloc = context.watch<SetupBloc>();
    bool regular = setupBloc.state.cycleType;
    int day1 = setupBloc.state.cycleMin;
    int day2 = setupBloc.state.cycleMax;

    return Container(
      alignment: Alignment.topCenter,
      height: 0.7.sh,
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            "cycle_last".tr(),
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(fontSize: 32.sp, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToggleButtons(
                isSelected: [regular, !regular],
                onPressed: (index) {
                  context.read<SetupBloc>().add(CycleTypeChanged(index == 0));
                },
                borderRadius: BorderRadius.circular(20),
                selectedColor: context.colors.onPrimary,
                fillColor: context.colors.primary,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text("regular".tr(), style: GoogleFonts.urbanist(fontSize: 18.sp)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text("irregular".tr(), style: GoogleFonts.urbanist(fontSize: 18.sp)),
                  ),
                ],
              ),
            ],
          ),
          regular
              ? Expanded(
            child: CupertinoPicker(
              scrollController: _day1Controller,
              itemExtent: 100,
              onSelectedItemChanged: (index) {
                context.read<SetupBloc>().add(CycleRangeChanged(index, index));
              },
              selectionOverlay: _buildSelectionOverlay(context),
              children: _buildPickerItems(context, day1),
            ),
          )
              : Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.1.sw),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: _day1Controller,
                      itemExtent: 100,
                      onSelectedItemChanged: (index) {
                        context.read<SetupBloc>().add(CycleRangeChanged(index, day2));
                      },
                      selectionOverlay: _buildSelectionOverlay(context),
                      children: _buildPickerItems(context, day1),
                    ),
                  ),
                  Text(
                    "-",
                    style: TextStyle(
                      fontSize: 40.sp,
                      color: context.colors.primary,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: _day2Controller,
                      itemExtent: 100,
                      onSelectedItemChanged: (index) {
                        context.read<SetupBloc>().add(CycleRangeChanged(day1, index));
                      },
                      selectionOverlay: _buildSelectionOverlay(context),
                      children: _buildPickerItems(context, day2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionOverlay(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1, color: context.colors.primary),
          bottom: BorderSide(width: 1, color: context.colors.primary),
        ),
      ),
    );
  }

  List<Widget> _buildPickerItems(BuildContext context, int selectedDay) {
    return List.generate(31, (index) {
      return Center(
        child: Text(
          "${index + 1}".padLeft(2).tr(),
          style: GoogleFonts.urbanist(
            fontSize: selectedDay == index ? 48.sp : 40.sp,
            color: selectedDay == index ? context.colors.primary : Colors.black.withOpacity(0.8),
            fontWeight: selectedDay == index ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      );
    });
  }
}
