import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/core/constants/app_icons.dart';
import 'package:lunari/presentation/blocs/add_log/add_log_cubit.dart';
import 'package:lunari/presentation/blocs/add_log/add_log_state.dart';
import 'package:lunari/presentation/screens/add_log/widget/background_box.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';

import '../../../../presentation/widgets/custom_button.dart';

class Weight extends StatefulWidget {
  const Weight({Key? key}) : super(key: key);

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  bool isKg = true;
  late WeightSliderController _controller;
  double _weight = 60.0;

  final List<Color> colors = [
    const Color(0xff1a96f0),
    const Color(0xff00a9f1),
    const Color(0xff00bcd3),
    const Color(0xff4aaf57),
    const Color(0xffffc02d),
    const Color(0xffff981f),
    const Color(0xffff5726),
    const Color(0xfff54336),
  ];

  @override
  void initState() {
    super.initState();
    _controller = WeightSliderController(
      initialWeight: _weight,
      minWeight: 0,
      interval: 0.1,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weightText = [
      {"first": "very_severely_underweight", "second": "BMI < 16.0"},
      {"first": "severely_underweight",         "second": "BMI 16.0 - 16.9"},
      {"first": "underweight",                  "second": "BMI 17.0 - 18.4"},
      {"first": "normal",                       "second": "BMI 18.5 - 24.9"},
      {"first": "overweight",                   "second": "BMI 25.0 - 29.9"},
      {"first": "obese_1",                      "second": "BMI 30.0 - 34.9"},
      {"first": "obese_2",                      "second": "BMI 35.0 - 39.9"},
      {"first": "obese_3",                      "second": "BMI ≥ 40.0"},
    ];

    return Scaffold(
      backgroundColor: context.colors.onSecondary,
      appBar: AppBar(
        backgroundColor: context.colors.onSecondary,
        surfaceTintColor: context.colors.onSecondary,
        centerTitle: true,
        title: Text(
          'weight'.tr(),
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.sp),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(AppIcons.settings),
          ),
        ],
      ),
      body: BlocBuilder<AddLogCubit, AddLogState>(
        builder: (context, state) {
          return ListView(
            children: [
              BackgroundBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ToggleButtons(
                          isSelected: [isKg, !isKg],
                          onPressed: (index) {
                            setState(() {
                              isKg = index == 0;
                              _weight = isKg ? (_weight / 2.205) : (_weight * 2.205);
                            });
                          },
                          borderRadius: BorderRadius.circular(10),
                          selectedColor: context.colors.onPrimary,
                          fillColor: const Color(0xff8bc255),
                          constraints: const BoxConstraints(minWidth: 50, minHeight: 30),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                              child: Text('kg', style: TextStyle(fontSize: 14.sp)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                              child: Text('lb', style: TextStyle(fontSize: 14.sp)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      '${_weight.toStringAsFixed(1)} ${isKg ? 'kg' : 'lb'}',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 45.sp,
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
                          onChanged: (value) => setState(() => _weight = value),
                          indicator: Container(
                            height: 3.0,
                            width: 200.0,
                            alignment: Alignment.centerLeft,
                            color: const Color(0xff8bc255),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              // BMI categories
              BackgroundBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Text(
                            'normal'.tr(),
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp),
                          ),
                          SizedBox(width: 4.sp),
                          Text(
                            '(22)',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: colors
                            .map((c) => Container(
                          height: 10,
                          width: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: c,
                          ),
                        ))
                            .toList(),
                      ),
                    ),
                    Center(child: SvgPicture.asset(AppIcons.arrowUp)),
                    for (int i = 0; i < colors.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(backgroundColor: colors[i], radius: 5),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                weightText[i]['first']!.tr(),
                                style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                              ),
                            ),
                            Text(
                              weightText[i]['second']!,
                              style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 18, bottom: 16, left: 24, right: 24),
        color: Colors.white,
        child: CustomButton(
          text: 'ok'.tr(),
          onClick: () {
            context.read<AddLogCubit>().updateWeight(_weight);
            Navigator.of(context).pop();
          },
          color: Colors.white,
          bgColor: const Color(0xffFF699C),
        ),
      ),
    );
  }
}

