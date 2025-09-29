import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/cubit/log_count/log_count_cubit.dart';
import 'package:lunari/presentation/screens/tracker/widgets/tracker_health.dart';
import 'package:lunari/presentation/screens/tracker/widgets/tracker_log_count.dart';

import '../../../data/repositories/log_repository.dart';
import '../../cubit/week_cubit/week_cubit.dart';


class Tracker extends StatefulWidget {
  const Tracker({super.key});

  @override
  State<Tracker> createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    context.read<LogCountCubit>().fetchAllCounts();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onSecondary,
      appBar: AppBar(
        backgroundColor: context.colors.onSecondary,
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
          "tracker".tr(),
          style: GoogleFonts.urbanist(
              fontSize: 24.sp,
              color: const Color(0xff212121),
              height: 1.4,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: InkWell(
              child: SvgPicture.asset("assets/icons/dots.svg"),
            ),
          )
        ],

        //! TabBar_buttons:
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: context.colors.outline,
                borderRadius: BorderRadius.circular(6),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: context.colors.primary,
                  borderRadius: BorderRadius.circular(6),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                dividerColor: Colors.transparent,
                labelStyle: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
                tabs:  [
                  Tab(
                    child: Text("log_count".tr()),
                  ),
                  Tab(
                    child: Text("health".tr()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children:  [
          LogCountSection(),
          BlocProvider<WeekCubit>(
            lazy: false,
            create: (context) => WeekCubit(repo: LogRepository(), uid: FirebaseAuth.instance.currentUser!.uid),
            child: BuildHealthSection(),
          )        ],
      ),
    );
  }
}




