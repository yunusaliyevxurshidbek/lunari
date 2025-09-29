import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/screens/account/reminder/widgets/reminder_widget.dart';

class Reminder extends StatefulWidget {
  const Reminder({super.key});

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {


  callAccountPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onSecondary,
      appBar: AppBar(
        backgroundColor: context.colors.onSecondary,
        title: Text(
          "reminder".tr(),
          style: GoogleFonts.urbanist(
              fontSize: 24.sp,
              color: const Color(0xff212121),
              height: 1.4,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24, top: 15, bottom: 15),
          child: GestureDetector(
            onTap: () {
              callAccountPage();
            },
            child: SvgPicture.asset(
              "assets/icons/arrow_left_long.svg",
              height: 28,
              width: 28,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 24),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.colors.onPrimary,
          ),
          child: const ReminderWidget(),
        ),
      ),

    );
  }
}
