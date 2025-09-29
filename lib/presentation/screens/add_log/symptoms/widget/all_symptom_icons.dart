import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../widget/background_box.dart';

class AllSymptomIcons extends StatefulWidget {
  @override
  _AllSymptomIconsState createState() => _AllSymptomIconsState();
}

class _AllSymptomIconsState extends State<AllSymptomIcons> {
  final List<Map<String, String>> symptoms = [
    {"icon": AppIcons.headaches, "label": "Headaches"},
    {"icon": AppIcons.insomnia, "label": "Insomnia"},
    {"icon": AppIcons.weightGain, "label": "Weight Gain"},
    {"icon": AppIcons.moodChange, "label": "Mood Changes"},
    {"icon": AppIcons.irregular, "label": "Irregular Period"},
    {"icon": AppIcons.memory, "label": "Memory Problems"},
    {"icon": AppIcons.nightSweats, "label": "Night Sweats"},
    {"icon": AppIcons.thinningHair, "label": "Thinning Hair"},
    {"icon": AppIcons.breastTenderness, "label": "Breast Tenderness"},
    {"icon": AppIcons.vaginalDryness, "label": "Vaginal Dryness"},
    {"icon": AppIcons.hotFlashes, "label": "Hot Flashes"},
    {"icon": AppIcons.jointPain, "label": "Joint Pain"},
  ];

  Set<int> selectedIndexes = {};

  @override
  Widget build(BuildContext context) {
    return BackgroundBox(
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icons:
          GridView.builder(
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
              bool isSelected = selectedIndexes.contains(index);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedIndexes.remove(index);
                    } else {
                      selectedIndexes.add(index);
                    }
                  });
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
                          color: isSelected ? context.colors.primary  : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: Image.asset(
                        symptoms[index]["icon"]!,
                        width: 70.w,
                        height: 70.h,
                      ),
                    ),
                    Text(
                      symptoms[index]["label"]!.tr(),
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
          ),
        ],
      ),
    );
  }
}
