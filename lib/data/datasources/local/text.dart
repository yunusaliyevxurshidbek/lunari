import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';

class ArticleText extends StatelessWidget {
  const ArticleText({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      spacing: 20,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("1. Menstrual Phase:",style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w700,
              color: context.colors.scrim,
              fontSize: 20.sp,
            ),),

            Text("This is the start of your cycle, "
                "marked by the shedding of your uterine "
                "lining. Most women bleed for 3-7 days, "
                "and it’s common to experience cramps, "
                "fatigue, and mood swings.",
              style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: context.colors.greyScale,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("2. Follicular Phase:",style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w700,
              color: context.colors.scrim,
              fontSize: 20.sp,
            ),),

            Text("After your period, your body prepares for ovulation. Estrogen levels rise, and an egg begins to mature in your ovaries. You might feel more energetic and notice improvements in your skin and mood.",
              style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: context.colors.greyScale,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("3. Ovulation Phase:",style: GoogleFonts.urbanist(
              fontWeight: FontWeight.w700,
              color: context.colors.scrim,
              fontSize: 20.sp,
            ),),

            Text("Ovulation phase is the stage in the menstrual cycle when a mature egg is released from the ovary. It usually occurs around the middle of the cycle (day 12-16 in a 28-day cycle). The egg survives for 12-24 hours, making this the most fertile period. Common signs include increased cervical mucus, mild abdominal pain, and a higher sex drive.",
              style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: context.colors.greyScale,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
