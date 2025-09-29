import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';
import '../../../../widgets/custom_button.dart';
import 'all_symptom_icons.dart';


class SymptomsMore extends StatefulWidget {
  const SymptomsMore({super.key});

  @override
  State<SymptomsMore> createState() => _SymptomsMoreState();
}

class _SymptomsMoreState extends State<SymptomsMore> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onSecondary,
      appBar: AppBar(
        backgroundColor: context.colors.onSecondary,
        surfaceTintColor:context.colors.onSecondary,
        centerTitle: true,
        title: Text(
          "Symptoms".tr(),
          style:  GoogleFonts.urbanist(
            fontWeight: FontWeight.w600,
            fontSize: 25.sp,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            context.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AllSymptomIcons(),
        ),
      ),
      bottomNavigationBar: Container(
        padding:
        const EdgeInsets.only(top: 18, bottom: 16, left: 24, right: 24),
        decoration: BoxDecoration(
          color: context.colors.onPrimary,
        ),
        child: CustomButton(
          text: "Ok",
          onClick: () {
            context.pop(context);
          },
          color: Colors.white,
          bgColor: const Color(0xffFF699C),
        ),
      ),
    );
  }
}
