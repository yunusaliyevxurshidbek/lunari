import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/cubit/week_cubit/week_cubit.dart';
import 'package:lunari/presentation/cubit/week_cubit/week_state.dart';



class WeekNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeekCubit, WeekState>(
      builder: (context,state) {
        String range = "${DateFormat("MMM d").format(state.startOfWeek)} – "
            "${DateFormat("MMM d, y").format(state.endOfWeek)}";
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/arrow_left.svg",
                height: 20,
                width: 20,
                color: context.colors.scrim,
              ),
              onPressed: () => context.read<WeekCubit>().previousWeek(),
            ),
            Text(
              range,
              style: GoogleFonts.urbanist(
                  height: 1.4, fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/arrow_right.svg",
                height: 20,
                width: 20,
                color: context.colors.scrim,
              ),
              onPressed: () => context.read<WeekCubit>().nextWeek(),
            ),
          ],
        );
      }
    );
  }
}
