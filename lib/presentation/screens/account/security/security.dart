import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/screens/account/security/widgets/security_widget.dart';

class Security extends StatefulWidget {
  const Security({super.key});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {

  callAccountPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onSecondary,
      appBar: AppBar(
        surfaceTintColor: context.colors.onSecondary,
        backgroundColor: context.colors.onSecondary,
        title: Text(
          "account_security".tr(),
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
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 8.0),
        child: SecurityWidget(),
      ) ,

    );
  }
}
