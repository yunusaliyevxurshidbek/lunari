import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/router/app_router.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';

class LogoutBottomSheet extends StatefulWidget {
  const LogoutBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
      ),
      builder: (context) => const LogoutBottomSheet(),
    );
  }

  @override
  _LogoutBottomSheetState createState() => _LogoutBottomSheetState();
}

class _LogoutBottomSheetState extends State<LogoutBottomSheet> {
  String selectedTheme = 'light';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 24, left: 24, top: 15, bottom: 36),
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('logout'.tr(),
              style: GoogleFonts.urbanist(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: context.colors.alert,
              )),

          Divider(
            thickness: 1,
            color: context.colors.dividerLight,
          ),

          Text('want_to_logout'.tr(),
              style: GoogleFonts.urbanist(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: context.colors.scrim,
              )),

          Divider(
            thickness: 1,
            color: context.colors.dividerLight,
          ),


          // buttons:
          Row(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: context.colors.secondary,
                    ),
                    child: Text('Cancel'.tr(),
                        style: GoogleFonts.urbanist(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: context.colors.primary,
                        )),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    try {
                      await FirebaseAuth.instance.signOut();
                      context.go(AppRouter.auth);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error in signing out: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: context.colors.primary,
                    ),
                    child: Text('ok'.tr(),
                        style: GoogleFonts.urbanist(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: context.colors.onPrimary,
                        )),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}