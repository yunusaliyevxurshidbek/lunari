import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/router/app_router.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/blocs/add_log/add_log_cubit.dart';
import 'package:lunari/presentation/blocs/add_log/add_log_state.dart';
import '../../../../core/constants/add_log_icons.dart';
import '../widget/background_box.dart';

class SymptomsGrid extends StatelessWidget {
  final List<String>? selectedSymptoms;
  const SymptomsGrid({Key? key, this.selectedSymptoms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Symptoms".tr(),
                  style: GoogleFonts.urbanist(
                    color: context.colors.scrim,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  context.push(AppRouter.symptoms);
                },
                child: SvgPicture.asset("assets/icons/arrow_right.svg"),
              ),
            ],
          ),

          // Icons:
          BlocBuilder<AddLogCubit, AddLogState>(
            builder: (context, state) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: symptoms.length,
                itemBuilder: (context, index) {
                  final symptom = symptoms[index];
                  final String label = symptom["label"] as String;
                  final String iconPath = symptom["icon"] as String;

                  bool isSelected = state.selectedSymptoms.contains(label);

                  return GestureDetector(
                    onTap: () {
                      context.read<AddLogCubit>().toggleSymptom(label);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 70.w,
                          height: 70.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? context.colors.primary : context.colors.dividerLight,
                              width: 1,
                            ),
                          ),
                          child: Image.asset(
                            iconPath,
                            width: 60.w,
                            height: 60.h,
                          ),
                        ),
                        Text(
                          label.tr(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: isSelected ? context.colors.primary : context.ccolors.greyScale700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
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
