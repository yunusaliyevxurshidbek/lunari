import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/screens/account/adding_card/widgets/adding_card_widget.dart';


class AddingCard extends StatefulWidget {
  const AddingCard({super.key});

  @override
  State<AddingCard> createState() => _AddingCardState();
}

class _AddingCardState extends State<AddingCard> {

  callPaymentMethod() {
    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onPrimary,
      appBar: AppBar(
        backgroundColor: context.colors.onPrimary,
        leading:Padding(
          padding: const EdgeInsets.only(left: 24, top: 15, bottom: 15),
          child: InkWell(
            child: SvgPicture.asset(
              "assets/icons/remove.svg",
            ),
          ),
        ),

        centerTitle: true,
        title: Text(
          "add_new_payment".tr(),
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
              child: SvgPicture.asset("assets/icons/scan.svg"),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 24),
        child: Stack(
          children: [
            const AddingCardWidget(),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                color: context.colors.onPrimary,
                child: GestureDetector(
                  onTap: () {
                    callPaymentMethod();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      color: context.colors.primary,
                    ),
                    child: Text(
                      "save".tr(),
                      style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w700,
                        color: context.colors.onPrimary,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),

    );
  }
}
