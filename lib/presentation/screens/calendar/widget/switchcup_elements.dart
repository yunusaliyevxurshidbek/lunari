import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import '../../../../core/constants/app_icons.dart';
import '../../add_log/widget/background_box.dart';

class SwitchCupElements extends StatefulWidget {
  @override
  _SwitchCupElementsState createState() => _SwitchCupElementsState();
}

class _SwitchCupElementsState extends State<SwitchCupElements> {
  final List<Map<String, String>> cups = [
    {"icon": AppIcons.ml100, "label": "100 mL"},
    {"icon": AppIcons.ml125, "label": "125 mL"},
    {"icon": AppIcons.ml150, "label": "150 mL"},
    {"icon": AppIcons.ml200, "label": "200 mL"},
    {"icon": AppIcons.ml250, "label": "250 mL"},
    {"icon": AppIcons.ml300, "label": "300 mL"},
    {"icon": AppIcons.ml350, "label": "350 mL"},
    {"icon": AppIcons.ml400, "label": "400 mL"},
    {"icon": AppIcons.ml500, "label": "500 mL"},
    {"icon": AppIcons.ml600, "label": "600 mL"},
    {"icon": AppIcons.addCustom, "label": "Add Custom"},



  ];

  int? selectedIndex;
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
            itemCount: cups.length,
            itemBuilder: (context, index) {
              bool isSelected = selectedIndex == index;


              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = isSelected ? null : index;
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
                          color: isSelected ? context.ccolors.blue  : context.ccolors.dividerLight,
                          width: 1,
                        ),
                      ),
                      child: Image.asset(
                        cups[index]["icon"]!,
                        width: 60.w,
                        height: 60.h,
                      ),
                    ),
                    Text(
                      cups[index]["label"]!.tr(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: isSelected ? context.ccolors.blue : context.ccolors.greyScale700,
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
