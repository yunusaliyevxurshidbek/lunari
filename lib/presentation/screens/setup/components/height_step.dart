import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';

import '../../../blocs/setup/setup_bloc.dart';
import '../../../blocs/setup/setup_event.dart';

class HeightStep extends StatefulWidget {
  const HeightStep({super.key});

  @override
  State<HeightStep> createState() => _HeightStepState();
}

class _HeightStepState extends State<HeightStep> {
    bool isSm = true;
    double weight = 60.0;

    late WeightSliderController _controller;
    double _weight = 60.0;

    @override
    void initState() {
      super.initState();
      _controller = WeightSliderController(
          initialWeight: context.read<SetupBloc>().state.height,
          minWeight: 0, interval: 0.1);
    }

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    final setupBloc = context.watch<SetupBloc>();
    double _height = setupBloc.state.height;
    return Container(
      alignment: Alignment.topCenter,
      height: 0.7.sh,
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            "how_tall".tr(),
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
                fontSize: 32.sp, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 50,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleButtons(
                    isSelected: [isSm, !isSm],
                    onPressed: (index) {
                      setState(() {
                        isSm = index == 0;
                        weight = isSm ? (weight / 2.205) : (weight * 2.205);
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    selectedColor: context.colors.onPrimary,
                    fillColor: context.colors.primary,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text("cm", style: TextStyle(fontSize: 18.sp)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text("ft", style: TextStyle(fontSize: 18.sp)),
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
                      text:
                          "${((isSm ? _height : (_height / 2.205))).toStringAsFixed(1)} ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 40.sp),
                    ),
                    TextSpan(
                      text: isSm ? 'cm' : 'ft',
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    )
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
                        _height = value;
                        context.read<SetupBloc>().add(HeightChanged(value));

                      });
                    },
                    indicator: Container(
                      height: 3.0,
                      width: 200.0,
                      alignment: Alignment.centerLeft,
                      color: context.colors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
