import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';

import '../../../../../data/models/card_model.dart';

class PaymentMethodWidget extends StatelessWidget {
  final CardInfo card;

  const PaymentMethodWidget({super.key, required this.card, });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 24, bottom: 15, top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            width: 1,
            color:
            context.colors.onPrimary),
        color: context.colors.onPrimary,
      ),
      child: Row(
        spacing: 5,
        children: [
          //! Image:
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(card.imageUrl),
          ),

          //! Name_email:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                card.name.tr(),
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w700,
                  color: context.colors.scrim,
                  fontSize: 18.sp,
                ),
              ),
              Text(
                card.email.tr(),
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w400,
                  color: context.colors.greyScale700,
                  fontSize: 14.sp,
                ),
              )
            ],
          ),

          Text("linked".tr(),style: GoogleFonts.urbanist(
            fontWeight: FontWeight.w700,
            color: context.ccolors.greyScale600,
            fontSize: 15.sp,
          ),),
        ],
      ),
    );
  }
}
