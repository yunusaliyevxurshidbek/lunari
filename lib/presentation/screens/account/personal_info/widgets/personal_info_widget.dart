import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/router/app_router.dart';
import 'package:lunari/core/utils/context_extention.dart';
import '../../../../blocs/user_panel/user_bloc.dart';
import '../../../../blocs/user_panel/user_state.dart';

class PersonalInfoWidget extends StatelessWidget {
  const PersonalInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context,state) {
        if (state.isLoading) {
          return const CircularProgressIndicator();
        }
        if (state.error != null) return Text('Error: ${state.error}');
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            // avatar:
            Stack(
              children: [
                ClipOval(
                  child: Image.asset(
                    "assets/images/female_avatar.png",
                    height: 80,
                    width: 80,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      context.push(AppRouter.edit_personal_info);
                    },
                    child: SvgPicture.asset(
                        "assets/icons/pencil.svg"
                    ),
                  ),
                ),
              ],
            ),


            // Infos:
            Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("full_name".tr(),style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  color: context.colors.scrim,
                  fontSize: 20.sp,
                ),),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 18),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: context.colors.outline,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1,color: context.colors.outline),
                  ),
                  child: Text(state.name.tr(),style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w600,
                    color: context.colors.scrim,
                    fontSize: 20.sp,
                  ),),

                ),
              ],
            ),
            Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("email".tr(),style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  color: context.colors.scrim,
                  fontSize: 20.sp,
                ),),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 18),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: context.colors.outline,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1,color: context.colors.outline),
                  ),
                  child: Row(
                    spacing: 5,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/email.svg",
                        width: 17.92,
                        height: 16.25,
                      ),
                      Text(state.email.tr(),style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w600,
                        color: context.colors.scrim,
                        fontSize: 18.sp,
                      ),),
                    ],
                  ),

                ),
              ],
            ),
            Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("phone_number".tr(),style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  color: context.colors.scrim,
                  fontSize: 20.sp,
                ),),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 18),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: context.colors.outline,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1,color: context.colors.outline),
                  ),
                  child: Row(
                    spacing: 5,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/usa_flag.svg",
                        width: 17.92,
                        height: 16.25,
                      ),
                      SvgPicture.asset(
                        "assets/icons/arrow_down.svg",
                        width: 17.92,
                        height: 16.25,
                      ),
                      const SizedBox(width: 5,),
                      Text("+1 (646) 555-4099",style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w600,
                        color: context.colors.scrim,
                        fontSize: 18.sp,
                      ),),
                    ],
                  ),

                ),
              ],
            ),
            Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("gender".tr(),style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  color: context.colors.scrim,
                  fontSize: 20.sp,
                ),),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 18),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: context.colors.outline,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1,color: context.colors.outline),
                  ),
                  child: Text("female".tr(),style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w600,
                    color: context.colors.scrim,
                    fontSize: 20.sp,
                  ),),

                ),
              ],
            ),
            Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("date_of_birth".tr(),style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  color: context.colors.scrim,
                  fontSize: 20.sp,
                ),),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 18),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: context.colors.outline,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1,color: context.colors.outline),
                  ),
                  child: Text(state.birthday,style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w600,
                    color: context.colors.scrim,
                    fontSize: 20.sp,
                  ),),

                ),
              ],
            ),
          ],
        );
      }

    );
  }
}
