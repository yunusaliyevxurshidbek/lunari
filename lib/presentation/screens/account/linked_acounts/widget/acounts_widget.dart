import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import '../../../../../data/models/accounts_model.dart';

class AccountsWidget extends StatelessWidget {
  final AccountInfo account;
  const AccountsWidget({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        padding: const EdgeInsets.only(top: 16,bottom: 16,right: 24,left: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.colors.onPrimary,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1,color: context.colors.onPrimary),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 10,
              children: [
                Image.asset(
                  account.imageUrl,
                  height: 50,
                  width: 50,
                ),
                Text(account.name.tr(),style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w700,
                  color: context.colors.scrim,
                  fontSize: 15.sp,
                ),),
              ],
            ),


            account.condition
                ? Text("linked".tr(),style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w700,
              color: context.ccolors.greyScale600,
              fontSize: 15.sp,
            ),)
                : Text("link".tr(),style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
              color: context.colors.primary,
            ),)

          ],
        ),

      ),
    );
  }
}
