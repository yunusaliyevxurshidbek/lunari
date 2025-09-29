import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:lunari/core/utils/context_extention.dart';
import '../../../../core/constants/menstrual_cycle_phases.dart';
import 'components/phase_item.dart';

class Phase extends StatefulWidget {
  const Phase({super.key});

  @override
  State<Phase> createState() => _PhaseState();
}

class _PhaseState extends State<Phase> {
  final PageController controller = PageController(
    viewportFraction: 0.5,
  );

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onPrimary,
      appBar: AppBar(
        backgroundColor: context.colors.onPrimary,
        surfaceTintColor: context.colors.onPrimary,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(
                Icons.close,
                color: const Color(0xff212121),
                size: 32.sp,
              )),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 1.sw,
              height: 160,
              child: PageView.builder(
                  itemCount: menstrualCyclePhases.length,
                  controller: controller,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 160,
                      height: 160,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(160),
                                color: menstrualCyclePhases[index]
                                    ["back_color"]),
                          ),
                          Positioned(
                              top: 0,
                              bottom: 0,
                              child: SvgPicture.asset(
                                  menstrualCyclePhases[index]["image"]))
                        ],
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                children: <Widget>[
                  Text(
                    menstrualCyclePhases[_currentPage]["title"],
                    style: GoogleFonts.urbanist(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                        color: const Color(0xff212121)),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Current phase",
                    style: GoogleFonts.urbanist(
                        fontSize: 14.sp,
                        height: 1.6,
                        letterSpacing: 0.2,
                        color: const Color(0xff616161)),
                  )
                ],
              ),
            ),
            PhaseItem(
                title: "What Happens:",
                description: menstrualCyclePhases[_currentPage]["happens"]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: PhaseItem(
                  title: "Symptoms:",
                  description: menstrualCyclePhases[_currentPage]["symptoms"]),
            ),
            PhaseItem(
                title: "Fertilization Chances:",
                level: menstrualCyclePhases[_currentPage]["chances_level"],
                description: menstrualCyclePhases[_currentPage]["chances"]),
          ],
        ),
      ),
    );
  }
}
