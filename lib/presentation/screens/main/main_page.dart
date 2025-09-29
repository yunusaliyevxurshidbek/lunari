import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../account/account.dart';
import '../articles/articles.dart';
import '../calendar/calendar.dart';
import '../home/home.dart';
import '../tracker/tracker.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

const pages = [Home(), Calendar(), Tracker(), Articles(), Account()];

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  currentIndex == 0
                      ? "assets/icons/home_active.svg"
                      : "assets/icons/home.svg",
                  colorFilter: ColorFilter.mode(
                      currentIndex == 0
                          ? const Color(0xffFF699C)
                          : Colors.black.withOpacity(0.4),
                      BlendMode.srcIn),
                ),
                label: 'home'.tr(),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  currentIndex == 1
                      ? "assets/icons/calendar_active.svg"
                      : "assets/icons/calendar.svg",
                  colorFilter: ColorFilter.mode(
                      currentIndex == 1
                          ? const Color(0xffFF699C)
                          : Colors.black.withOpacity(0.4),
                      BlendMode.srcIn),
                ),
                label: 'calendar'.tr(),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  currentIndex == 2
                      ? "assets/icons/insights_active.svg"
                      : "assets/icons/insights.svg",
                  colorFilter: ColorFilter.mode(
                      currentIndex == 2
                          ? const Color(0xffFF699C)
                          : Colors.black.withOpacity(0.4),
                      BlendMode.srcIn),
                ),
                label: 'tracker'.tr(),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  currentIndex == 3
                      ? "assets/icons/article_active.svg"
                      : "assets/icons/article.svg",
                  colorFilter: ColorFilter.mode(
                      currentIndex == 3
                          ? const Color(0xffFF699C)
                          : Colors.black.withOpacity(0.4),
                      BlendMode.srcIn),
                ),
                label: 'articles'.tr(),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  currentIndex == 4
                      ? "assets/icons/user_active.svg"
                      : "assets/icons/user.svg",
                  colorFilter: ColorFilter.mode(
                      currentIndex == 4
                          ? const Color(0xffFF699C)
                          : Colors.black.withOpacity(0.4),
                      BlendMode.srcIn),
                ),
                label: 'account'.tr(),
                backgroundColor: Colors.white),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          selectedItemColor: const Color(0xffFF699C),
          selectedLabelStyle: GoogleFonts.urbanist(
              fontSize: 10.sp,
              color: const Color(0xffFF699C),
              height: 1.6,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold),
          iconSize: 40,
          showUnselectedLabels: true,
          unselectedLabelStyle: GoogleFonts.urbanist(
              fontSize: 10.sp,
              letterSpacing: 1.2,
              color: const Color(0xff9E9E9E),
              height: 1.6,
              fontWeight: FontWeight.w500),
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          elevation: 5),
    );
  }
}
