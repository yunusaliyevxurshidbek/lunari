import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/router/app_router.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Personalizing extends StatefulWidget {
  const Personalizing({super.key});

  @override
  State<Personalizing> createState() => _PersonalizingState();
}

class _PersonalizingState extends State<Personalizing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();

    Timer(const Duration(seconds: 5), () {
      context.push(AppRouter.main);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      height: 0.8.sh,
      width: 1.sw,
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "we_setting_up".tr(),
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                    fontSize: 24.sp, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          CircularPercentIndicator(
            radius: 100,
            lineWidth: 12.0,
            percent: _animation.value,
            circularStrokeCap: CircularStrokeCap.round,
            center: Text(
              "${(_animation.value * 100).toStringAsFixed(1)}%",
              style: GoogleFonts.urbanist(
                fontWeight: FontWeight.bold,
                fontSize: 45.sp,
              ),
            ),
            progressColor: context.colors.primary,
            backgroundColor: context.ccolors.dividerLight,
          ),
          Text(
            "take_moment".tr(),
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
                fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}