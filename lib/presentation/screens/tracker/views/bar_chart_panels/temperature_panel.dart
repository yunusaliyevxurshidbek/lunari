import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunari/core/utils/context_extention.dart';

import '../../../../cubit/week_cubit/week_cubit.dart';
import '../../../../cubit/week_cubit/week_state.dart';
import '../../charts/bar_chart/bar_graph.dart';
import '../../charts/line_graphs/line_graph.dart';
import '../chart_types.dart';
import '../week_navigator.dart';

class TemperaturePanel extends StatefulWidget {
  const TemperaturePanel({super.key});

  @override
  State<TemperaturePanel> createState() => _TemperaturePanelState();
}

class _TemperaturePanelState extends State<TemperaturePanel> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: context.colors.onPrimary,
              borderRadius: BorderRadius.circular(6)),
          child: Column(
            spacing: 16,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    spacing: 4,
                    children: [
                      Text(
                        "temperature".tr(),
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          color: context.colors.scrim,
                        ),
                      ),
                      Text(
                        "(°C)",
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          color: context.colors.scrim,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 32,
                    width: 104,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: context.colors.onSecondary),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: const Color(0xFFFF981F),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      unselectedLabelColor: const Color(0xFFFF981F),
                      dividerColor: Colors.transparent,
                      onTap: (index) => setState(() {
                        tabIndex = index;
                      }),
                      tabs: [
                        Tab(
                          child: SvgPicture.asset(
                            tabIndex == 0
                                ? "assets/icons/chart.svg"
                                : "assets/icons/chart_black.svg",
                            height: 20,
                            width: 20,
                          ),
                        ),
                        Tab(
                          child: SvgPicture.asset(
                            tabIndex == 1
                                ? "assets/icons/chart2.svg"
                                : "assets/icons/chart2_black.svg",
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Divider(
                color: context.colors.onTertiary,
              ),
               WeekNavigator(),
               SizedBox(
                height: 270,
                child: TabBarView(
                  children: [
                    BlocBuilder<WeekCubit, WeekState>(
                      builder: (context, state) {
                        return MyBarGraph(
                          yAxisType: YAxisType.temperature,
                          startOfWeek: state.startOfWeek,
                          endOfWeek: state.endOfWeek,
                        );
                      },
                    ),
                    BlocBuilder<WeekCubit, WeekState>(
                      builder: (context, state) {
                        return MyLineGraph(
                          yAxisType: YAxisType.temperature,
                          startOfWeek: state.startOfWeek,
                          endOfWeek: state.endOfWeek,
                        );
                      },
                    ),

                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
