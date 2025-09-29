import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/blocs/user_panel/user_bloc.dart';
import 'package:lunari/presentation/blocs/user_panel/user_state.dart';
import 'package:lunari/presentation/screens/tracker/widgets/log_count_widgets/filter_buttons.dart';
import 'package:lunari/presentation/screens/tracker/widgets/log_count_widgets/history_period.dart';
import 'customize_cards/custom_card.dart';

class MyCyclesPage extends StatefulWidget {
  const MyCyclesPage({super.key});

  @override
  State<MyCyclesPage> createState() => _MyCyclesPageState();
}

class _MyCyclesPageState extends State<MyCyclesPage> {
  callTrackerHealth() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        if (state.isLoading) return CircularProgressIndicator();
        if (state.error != null) return Text('Error: ${state.error}');

          return Scaffold(
            backgroundColor: context.colors.onSecondary,
            appBar: AppBar(
              backgroundColor: context.colors.onSecondary,
              surfaceTintColor: context.colors.onSecondary,
              centerTitle: true,
              title: Text(
                "my_cycles".tr(),
                style: GoogleFonts.urbanist(
                    fontSize: 24.sp,
                    color: const Color(0xff212121),
                    height: 1.4,
                    fontWeight: FontWeight.bold),
              ),
              leading: GestureDetector(
                onTap: () {
                  callTrackerHealth();
                },
                child: const Image(
                  image: AssetImage("assets/images/arrow_left_long.png"),
                  height: 24,
                  width: 24,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // TODO
                      },
                      child: CustomCard(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // 1:
                                Container(
                                  width: 0.5.sw - 50,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: context.colors.onSecondary,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        // " ${user.period.toString()} days ".tr(),
                                        "Period",
                                        style: GoogleFonts.urbanist(
                                          color: const Color(0xFF212121),
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        "average_period".tr(),
                                        style: GoogleFonts.urbanist(
                                          fontSize: 11.sp,
                                          color: const Color(0xFF616161),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/blood.svg",
                                            width: 50,
                                            height: 50,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // 2:
                                Container(
                                  width: 0.5.sw - 50,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: context.colors.onSecondary,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        // " ${user.cycle?.toString()} days ".tr(),   // []
                                        "4",
                                        style: GoogleFonts.urbanist(
                                          color: const Color(0xFF212121),
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        "average_cycle".tr(),
                                        style: GoogleFonts.urbanist(
                                          fontSize: 11.sp,
                                          color: const Color(0xFF616161),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Image(
                                            image: AssetImage(
                                              "assets/images/calendar_spiral.png",
                                            ),
                                            height: 50,
                                            width: 50,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1000),
                                color: const Color(0xFFFF699C),
                              ),
                              child: Text(
                                "edit_period".tr(),
                                style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: const Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "history".tr(),
                            style: GoogleFonts.urbanist(
                              color: const Color(0xff212121),
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const FilterButtons(),
                          const HistoryPeriod(
                            day: '28',
                            number: '4',
                            degree: 0.18,
                          ),
                          const HistoryPeriod(
                              day: '29', number: '5', degree: 0.25),
                          const HistoryPeriod(
                              day: '26', number: '4', degree: 0.1),
                          const HistoryPeriod(
                            day: '30',
                            number: '6',
                            degree: 0.28,
                          ),
                          const HistoryPeriod(
                            day: '29',
                            number: '4',
                            degree: 0.25,
                          ),
                          const HistoryPeriod(
                            day: '28',
                            number: '5',
                            degree: 0.18,
                          ),
                          const HistoryPeriod(
                            day: '28',
                            number: '4',
                            degree: 0.18,
                          ),
                          const HistoryPeriod(
                            day: '30',
                            number: '5',
                            degree: 0.26,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}