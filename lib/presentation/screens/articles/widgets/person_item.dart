import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';
import '../../../../data/models/user_model.dart';

class PersonItem extends StatelessWidget {
  final RecentUsers user;

  const PersonItem(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        spacing: 5,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(user.imageUrl),
          ),
          Text(
            '${user.name.split(' ')[0]}\n${user.name.split(' ')[1]}'.tr(),
            style: GoogleFonts.urbanist(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: context.colors.scrim,
            ),
          )
        ],
      ),
    );
  }
}
