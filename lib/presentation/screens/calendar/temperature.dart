import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Bloc kutubxonasini qo'shing
import 'package:go_router/go_router.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/screens/add_log/widget/background_box.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';
import '../../../../presentation/widgets/custom_button.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/services/log_service.dart';
import '../../blocs/add_log/add_log_cubit.dart';
import '../../blocs/add_log/add_log_state.dart';

class Temperature extends StatefulWidget {
  const Temperature({super.key});

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  bool isCelsius = true;
  bool isFahrenheit = false;
  bool isKelvin = false;
  bool isRankine = false;

  late WeightSliderController _controller;
  double _temperature = 36.5;

  @override
  void initState() {
    super.initState();
    _controller = WeightSliderController(
        initialWeight: _temperature, minWeight: 0, interval: 0.1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onSecondary,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(AppIcons.settings),
          )
        ],
        centerTitle: true,
        title: Text(
          "temperature".tr(),
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.sp),
        ),
        backgroundColor: context.colors.onSecondary,
        surfaceTintColor: context.colors.onSecondary,
      ),
      body: BlocBuilder<AddLogCubit, AddLogState>(
        builder: (context, state) {
          return ListView(
            children: [
              BackgroundBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ToggleButtons(
                          isSelected: [
                            isCelsius,
                            isFahrenheit,
                            isKelvin,
                            isRankine
                          ],
                          onPressed: (index) {
                            setState(() {
                              isCelsius = index == 0;
                              isFahrenheit = index == 1;
                              isKelvin = index == 2;
                              isRankine = index == 3;
                            });
                          },
                          borderRadius: BorderRadius.circular(10),
                          selectedColor: context.colors.onPrimary,
                          fillColor: const Color(0xffff981f),
                          constraints:
                          const BoxConstraints(minWidth: 10, minHeight: 15),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: Text("°C", style: TextStyle(fontSize: 14.sp)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: Text("°F", style: TextStyle(fontSize: 14.sp)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: Text("°K", style: TextStyle(fontSize: 14.sp)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: Text("°R", style: TextStyle(fontSize: 14.sp)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: _temperature.toStringAsFixed(1),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 45.sp),
                          ),
                          TextSpan(
                            text: isCelsius
                                ? " °C"
                                : isFahrenheit
                                ? " °F"
                                : isKelvin
                                ? " °K"
                                : " °R",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 45.sp),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: VerticalWeightSlider(
                          controller: _controller,
                          decoration: const PointerDecoration(
                            width: 130.0,
                            height: 3.0,
                            largeColor: Color(0xFF898989),
                            mediumColor: Color(0xFFC5C5C5),
                            smallColor: Color(0xFFF0F0F0),
                            gap: 30.0,
                          ),
                          onChanged: (double value) {
                            setState(() {
                              _temperature = value;
                            });
                          },
                          indicator: Container(
                            height: 3.0,
                            width: 200.0,
                            alignment: Alignment.centerLeft,
                            color: const Color(0xffff981f),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              BackgroundBox(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "infants".tr(),
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "36.5 - 37.5°C".tr(),
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            "children".tr(),
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "36.5 - 37°C".tr(),
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            "adults".tr(),
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "36.5 - 37.6°C".tr(),
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            "elderly".tr(),
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "35.8 - 36.9°C".tr(),
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        padding:
        const EdgeInsets.only(top: 18, bottom: 16, left: 24, right: 24),
        decoration: const BoxDecoration(color: Colors.white),
        child: CustomButton(
          text: "ok".tr(),
          onClick: () {
            context.read<AddLogCubit>().updateTemperature(_temperature);
            LogService.i("Selected Temperature: $_temperature ${isCelsius ? '°C' : isFahrenheit ? '°F' : isKelvin ? '°K' : '°R'}");
            context.pop(context);
          },
          color: Colors.white,
          bgColor: const Color(0xffFF699C),
        ),
      ),
    );
  }
}