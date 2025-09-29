import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';

import '../../../blocs/setup/setup_bloc.dart';
import '../../../blocs/setup/setup_event.dart';

class PeriodStep extends StatefulWidget {
  const PeriodStep({super.key});

  @override
  State<PeriodStep> createState() => _PeriodStepState();
}

class _PeriodStepState extends State<PeriodStep> {
  late FixedExtentScrollController _dayController;

  @override
  void initState() {
    super.initState();
    final initialPeriod = context.read<SetupBloc>().state.period;
    _dayController = FixedExtentScrollController(initialItem: initialPeriod);
  }

  @override
  void dispose() {
    _dayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final setupBloc = context.watch<SetupBloc>();
    int day1 = setupBloc.state.period;
    return Container(
      alignment: Alignment.topCenter,
      height: 0.7.sh,
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            "period_last".tr(),
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
                fontSize: 32.sp, fontWeight: FontWeight.w700),
          ),
          Expanded(
            child: CupertinoPicker(
              scrollController: _dayController,
              itemExtent: 100,
              onSelectedItemChanged: (index) {
                context.read<SetupBloc>().add(PeriodChanged(index));

              },
              selectionOverlay: Container(
                height: 100,
                width: 180,
                margin: EdgeInsets.symmetric(horizontal: (1.sw - 180) / 2),
                decoration: BoxDecoration(
                    border: Border(
                        top:
                            BorderSide(width: 1, color: context.colors.primary),
                        bottom: BorderSide(
                            width: 1, color: context.colors.primary))),
              ),
              children: List.generate(31, (index) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: day1 == index ? 40 : 0),
                    child: RichText(
                      text: TextSpan(
                          text: "${index}".padLeft(
                            2,
                          ).tr(),
                          style: GoogleFonts.urbanist(
                            fontSize: day1 == index ? 48.sp : 40.sp,
                            color: day1 == index
                                ? context.colors.primary
                                : const Color(0xff424242),
                            fontWeight: day1 == index
                                ? FontWeight.bold
                                : FontWeight.w600,
                          ),
                          children: <TextSpan>[
                            if (day1 == index)
                              TextSpan(
                                text: "day".tr(),
                                style: GoogleFonts.urbanist(
                                  fontSize: 18.sp,
                                  color: const Color(0xff212121),
                                  letterSpacing: 0.2,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                          ]),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
