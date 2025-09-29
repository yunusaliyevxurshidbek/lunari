import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';

import '../../../../core/router/app_router.dart';

class InviteFriend extends StatefulWidget {
  const InviteFriend({super.key});

  @override
  State<InviteFriend> createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("invite".tr(),style: GoogleFonts.urbanist(
          fontWeight: FontWeight.w700,
          fontSize: 25.sp,
          color: context.colors.onPrimaryContainer
        ),),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.5),
          child: Container(
            color: context.ccolors.dividerLight,
            height: 1.5,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30,),

            Image.asset(
              "assets/images/communication.png",
            ),

            const SizedBox(height: 30,),

            Text("add_friends_to_share".tr(),
              style:GoogleFonts.urbanist(
                fontWeight: FontWeight.w700,
                fontSize: 25.sp,
                color: context.colors.primary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10,),

            SizedBox(
              width: 200,
              child: Text("visible_to_friend".tr(),
              style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w400,
                fontSize: 15.sp,
                color: context.ccolors.greyScale600,
              ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 40,),


            // button:
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: (){
                context.push(AppRouter.addFriend);
              },
              child: Container(
                width: 200,
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: context.colors.primary,
                ),
                child: Text("invite_friends".tr(),style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  fontSize: 22.sp,
                  color: context.colors.onPrimary,
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
