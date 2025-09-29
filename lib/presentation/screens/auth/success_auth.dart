import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/router/app_router.dart';
import 'package:lunari/core/utils/context_extention.dart';
import '../../../../presentation/widgets/custom_button.dart';

class SuccessAuth extends StatelessWidget {
  const SuccessAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 120,
              height: 120,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: const Color(0xffCC547D),
                  borderRadius: BorderRadius.circular(120)),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      left: 0,
                      right: 0,
                      top: 25,
                      bottom: 0,
                      child: SvgPicture.asset(
                        "assets/icons/phone.svg",
                      )),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: 25,
                      child: Container(
                        alignment: Alignment.center,
                        child: Container(
                          width: 27,
                          height: 27,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: const Color(0xffCC547D),
                              borderRadius: BorderRadius.circular(27)),
                          child: SvgPicture.asset(
                            "assets/icons/user_active.svg",
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 15),
              child: Text(
                "all_set".tr(),
                style: GoogleFonts.urbanist(
                    fontSize: 32.sp, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "password_updated".tr(),
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 36),
        child:  GestureDetector(
          onTap: (){
            context.push(AppRouter.home);
          },
          child: CustomButton(
            text: "sign_in".tr(),
            bgColor: context.colors.onPrimary,
            color: context.colors.primary,
          ),
        ),
      ),
    );
  }
}
