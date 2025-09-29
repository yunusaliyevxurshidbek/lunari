import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import '../../../../core/constants/add_log_icons.dart';
import '../../../blocs/add_log/add_log_cubit.dart';
import '../../../blocs/add_log/add_log_state.dart';
import '../widget/background_box.dart';

class FlowGrid extends StatelessWidget {
  final String? selectedFlow;

  const FlowGrid({Key? key, this.selectedFlow}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BackgroundBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Flow".tr(),
              style: GoogleFonts.urbanist(
                color: context.colors.scrim,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

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
                itemCount: flow.length,
                itemBuilder: (context, index) {
                  final flowItem = flow[index];
                  final flowLabel = flowItem["label"] as String;
                  final flowIcon = flowItem["icon"] as String;
                  bool isSelected = state.selectedFlow == flowLabel;

                  return GestureDetector(
                    key: ValueKey(flowLabel),
                    onTap: () {
                      context.read<AddLogCubit>().selectFlow(flowLabel);
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
                            flowIcon,
                            width: 60.w,
                            height: 60.h,
                          ),
                        ),
                        Text(
                          flowLabel.tr(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: isSelected ? context.colors.primary : context.colors.greyScale700,
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
