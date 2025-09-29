import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/blocs/add_log/add_log_cubit.dart';
import 'package:lunari/presentation/blocs/add_log/add_log_state.dart';
import '../../../../core/constants/add_log_icons.dart';
import '../widget/background_box.dart';

class MedicineGrid extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BackgroundBox(
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Title:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Medicine".tr(),
              style: GoogleFonts.urbanist(
                color: context.colors.scrim,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          // Icons:
          BlocBuilder<AddLogCubit,AddLogState>(
            builder: (context,state) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: contraceptives.length,
                itemBuilder: (context, index) {

                  String label = contraceptives[index] ["label"]!;
                  bool isSelected = state.selectedMedicines.contains(label);

                  return GestureDetector(
                    onTap: () {
                      context.read<AddLogCubit>().toggleMedicine(label);
                    },
                    child: Column(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 70.w,
                          height: 70.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? context.colors.primary  : context.ccolors.dividerLight,
                              width: 1,
                            ),
                          ),
                          child: Image.asset(
                            contraceptives[index]["icon"]!,
                            width: 60.w,
                            height: 60.h,
                          ),
                        ),
                        Text(
                          contraceptives[index]["label"]!.tr(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: isSelected ? context.colors.primary : context.ccolors.greyScale700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
