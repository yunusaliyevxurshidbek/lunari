import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';
import '../widgets/contact_support_widget.dart';

class ContactSupport extends StatefulWidget {
  const ContactSupport({super.key});

  @override
  State<ContactSupport> createState() => _ContactSupportState();
}

class _ContactSupportState extends State<ContactSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onSecondary,
      appBar: AppBar(
        surfaceTintColor: context.colors.onPrimary,
        backgroundColor: context.colors.onSecondary,
        title: Text(
          "contact_support".tr(),
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
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              "assets/icons/arrow_left_long.svg",
              height: 28,
              width: 28,
            ),
          ),
        ),
      ),
      body:  Padding(
        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
        child: Column(
          spacing: 15,
          children: [
            ContactSupportWidget(
              icon: "assets/icons/customer_support.svg",
              title: "customer_support".tr(),
            ),
            ContactSupportWidget(
              icon: "assets/icons/website.svg",
              title: "website".tr(),
            ),
            ContactSupportWidget(
              icon: "assets/icons/whatsapp-2.svg",
              title: "WhatsApp",
            ),
            ContactSupportWidget(
              icon: "assets/icons/facebook-2.svg",
              title: "Facebook",
            ),
            ContactSupportWidget(
              icon: "assets/icons/x-2.svg",
              title: "X",
            ),
            ContactSupportWidget(
              icon: "assets/icons/instagram-3.svg",
              title: "Instagram",
            ),

          ],
        ),
      ),

    );
  }
}
