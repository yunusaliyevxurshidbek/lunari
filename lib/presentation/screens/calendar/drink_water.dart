import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/blocs/water/water_bloc.dart';
import 'package:lunari/presentation/blocs/water/water_state.dart';
import 'package:lunari/presentation/screens/add_log/widget/background_box.dart';
import 'package:lunari/core/constants/app_icons.dart';
import 'package:lunari/presentation/screens/calendar/switch_cup.dart';
import '../../blocs/add_log/add_log_cubit.dart';
import '../../blocs/water/water_event.dart';
import '../../widgets/custom_button.dart';
import '../add_log/animation/wave_animation.dart';


class DrinkWater extends StatefulWidget {
  const DrinkWater({super.key});

  @override
  State<DrinkWater> createState() => _DrinkWaterState();
}

class _DrinkWaterState extends State<DrinkWater> {
  @override
  void initState() {
    super.initState();
    context.read<WaterBloc>().add(LoadWaterData());
    _loadWaterDataFromAddLog();
  }

  void _loadWaterDataFromAddLog() {
    final addLogState = context.read<AddLogCubit>().state;
    if (addLogState.totalWaterConsumed > 0) {
      context.read<WaterBloc>().add(UpdateWaterFromAddLog(
        totalWater: addLogState.totalWaterConsumed,
        lastConsumedWater: addLogState.lastConsumedWater,
        lastConsumedIcon: addLogState.lastConsumedIcon,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(AppIcons.settings),
          )
        ],
        centerTitle: true,
        title: Text(
          "drink_water".tr(),
          style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w700,
              fontSize: 25.sp,
              color: context.colors.scrim
          ),
        ),
        backgroundColor: const Color(0xfff5f5f5),
      ),
      body: Center(
        child: BackgroundBox(
          child: Column(
            spacing: 10,
            children: [
              //! Main_icon:
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  BlocBuilder<WaterBloc, WaterState>(
                    builder: (context, state) {
                      final isGoalReached = state.totalWaterConsumed >= 2400;
                      return SvgPicture.asset(
                        "assets/icons/drink_water.svg",
                        color: isGoalReached ? Colors.blue : null,
                      );
                    },
                  ),
                  BlocBuilder<WaterBloc, WaterState>(
                    builder: (context, state) {
                      final isGoalReached = state.totalWaterConsumed >= 2400;
                      if (!isGoalReached) {
                        return ClipOval(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: WaveAnimation(
                              totalConsumedWater: state.totalWaterConsumed.toDouble(),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  BlocBuilder<WaterBloc, WaterState>(
                    builder: (context, state) {
                      return Text(
                        state.totalWaterConsumed.toString().tr(),
                        style: GoogleFonts.urbanist(
                          fontSize: 45.sp,
                          fontWeight: FontWeight.w600,
                          color: context.colors.onPrimaryContainer,
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "ml".tr(),
                      style: GoogleFonts.urbanist(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        color: context.ccolors.greyScale700,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("daily_goal".tr()),
                    Text(
                      " 2,400 mL ".tr(),
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SvgPicture.asset(AppIcons.pensil)
                  ],
                ),
              ),

              BlocBuilder<WaterBloc, WaterState>(
                builder: (context, state) {
                  return Row(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 1.5,
                            color: context.ccolors.dividerLight,
                          ),
                        ),
                        child: Image.asset(state.lastConsumedIcon),
                      ),
                      MaterialButton(
                        elevation: 0,
                        height: 60,
                        color: Colors.blue,
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SwitchCup()),
                          );

                          if (result != null) {
                            context.read<WaterBloc>().add(AddWater(
                                result['amount'],
                                result['icon']
                            ));

                            _updateAddLogWithWaterData(result);
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              spacing: 4,
                              children: [
                                Text(
                                  'drink'.tr(),
                                  style: GoogleFonts.urbanist(
                                    color: context.colors.onPrimary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                Text(
                                  '(${state.lastConsumedWater} mL)',
                                  style: GoogleFonts.urbanist(
                                    color: context.colors.onPrimary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ],
                            )
                        ),
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 18, bottom: 16, left: 24, right: 24),
        decoration: const BoxDecoration(color: Colors.white),
        child: CustomButton(
          text: "ok".tr(),
          onClick: () {
            _syncWaterDataToAddLog();
            context.pop(context);
          },
          color: Colors.white,
          bgColor: context.ccolors.blue,
        ),
      ),
    );
  }


  void _updateAddLogWithWaterData(Map<String, dynamic> result) {
    final currentWaterBloc = context.read<WaterBloc>().state;
    final amount = (result['amount'] as num).toInt();

    context.read<AddLogCubit>().updateWaterConsumption(
      total: currentWaterBloc.totalWaterConsumed + amount,
    );

    context.read<AddLogCubit>().updateLastConsumedWater(
      lastConsumedWater: amount,
      lastConsumedIcon: result['icon'] as String,
    );
  }

  void _syncWaterDataToAddLog() {
    final waterState = context.read<WaterBloc>().state;

    context.read<AddLogCubit>().updateWaterConsumption(
      total: waterState.totalWaterConsumed,
    );

    context.read<AddLogCubit>().updateLastConsumedWater(
      lastConsumedWater: waterState.lastConsumedWater,
      lastConsumedIcon: waterState.lastConsumedIcon,
    );
  }
}

