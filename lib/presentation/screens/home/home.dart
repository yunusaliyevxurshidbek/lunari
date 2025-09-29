import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/blocs/home_tracker/tracker_bloc.dart';
import 'package:lunari/presentation/blocs/home_tracker/tracker_state.dart';
import 'components/info_panel.dart';
import 'components/tracker_panel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onSecondary,
      appBar: AppBar(
        backgroundColor: context.colors.onSecondary,
        surfaceTintColor: context.colors.onSecondary,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24, top: 15, bottom: 15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              "assets/images/logo_filled.png",
              fit: BoxFit.contain,
              width: 22,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "lunari".tr(),
          style: GoogleFonts.urbanist(
              fontSize: 24.sp,
              color: const Color(0xff212121),
              height: 1.4,
              fontWeight: FontWeight.bold),
        ),
      ),
      body:  SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: Column(
          children: <Widget>[
            BlocBuilder<TrackerBloc, TrackerState>(
              builder: (context, state) {
                return TrackerPanel(
                  currentDayNumber: state.currentDayNumber,
                  totalDaysForContext: state.totalDaysForContext,
                  isInPeriod: state.isInPeriod,
                  ovulationDaysLeft: state.ovulationDaysLeft,
                  onEdit: () => context.push('/edit_period'),
                );
              },
            ),

            InfoPanel(),
          ],
        ),
      ),
    );
  }
}
