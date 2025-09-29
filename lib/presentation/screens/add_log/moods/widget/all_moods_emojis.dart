import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import '../../widget/background_box.dart';

class AllMoodsEmojis extends StatefulWidget {
  @override
  _AllMoodsEmojisState createState() => _AllMoodsEmojisState();
}

class _AllMoodsEmojisState extends State<AllMoodsEmojis> {
  final List<Map<String, String>> moods = [
    {"emoji": "😐", "label": "Normal"},
    {"emoji": "😡", "label": "Angry"},
    {"emoji": "😊", "label": "Happy"},
    {"emoji": "😭", "label": "Sad"},
    {"emoji": "😵", "label": "Exhausted"},
    {"emoji": "😰", "label": "Anxious"},
    {"emoji": "😔", "label": "Depressed"},
    {"emoji": "😍", "label": "In Love"},
    {"emoji": "😞", "label": "Bored"},
    {"emoji": "😎", "label": "Confident"},
    {"emoji": "😃", "label": "Excited"},
    {"emoji": "😌", "label": "Relaxed"},
    {"emoji": "😖", "label": "Miserable"},
    {"emoji": "👿", "label": "Harsh"},
    {"emoji": "😇", "label": "Angelic"},
    {"emoji": "💪", "label": "Assertive"},
    {"emoji": "😞", "label": "Disappointed"},
    {"emoji": "😢", "label": "Emotional"},
    {"emoji": "👺", "label": "Evil"},
    {"emoji": "😳", "label": "Embarrassed"},
    {"emoji": "😤", "label": "Frustrated"},
    {"emoji": "😊", "label": "Good"},
    {"emoji": "😔", "label": "Lonely"},
    {"emoji": "😜", "label": "Playful"},
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
            itemCount: moods.length,
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
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? context.colors.primary  : context.ccolors.dividerLight,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        moods[index]["emoji"]!,
                        style: TextStyle(
                          fontSize: 30.sp,
                        ),
                      ),
                    ),
                    Text(
                      moods[index]["label"]!.tr(),
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
