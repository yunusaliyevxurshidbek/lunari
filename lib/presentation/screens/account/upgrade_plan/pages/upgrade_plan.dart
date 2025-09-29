import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/screens/account/upgrade_plan/pages/yearly.dart';
import 'monthly.dart';



class UpgradePlan extends StatefulWidget {
  const UpgradePlan({super.key});

  @override
  State<UpgradePlan> createState() => _UpgradePlanState();
}

class _UpgradePlanState extends State<UpgradePlan> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  callSubscriptionBanner(BuildContext context){
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onSecondary,
      appBar: AppBar(
        backgroundColor: context.colors.onSecondary,
        title: Text(
          "upgrade_plan".tr(),
          style: GoogleFonts.urbanist(
              fontSize: 24.sp,
              color: const Color(0xff212121),
              height: 1.4,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24, top: 15, bottom: 15),
          child: GestureDetector(
            onTap: () {
              callSubscriptionBanner(context);
            },
            child: SvgPicture.asset(
              "assets/icons/arrow_left_long.svg",
              height: 28,
              width: 28,
            ),
          ),
        ),
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
                    child: Text("monthly".tr()),
                  ),
                  Tab(
                    child: Text("yearly".tr()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
      controller: _tabController,
      children:  const [
        Monthly(),
        Yearly(),
      ],
    ),
    );
  }
}
