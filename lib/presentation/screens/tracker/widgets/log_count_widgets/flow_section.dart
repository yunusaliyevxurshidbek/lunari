import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/presentation/screens/tracker/customize_cards/circle_widget.dart';
import 'package:lunari/presentation/screens/tracker/customize_cards/custom_card.dart';

class StatsSection extends StatelessWidget {
  final String title;
  final List<String> icons;
  final List<String> labels;
  final List<int> counts;

  const StatsSection({
    required this.title,
    required this.icons,
    required this.labels,
    required this.counts,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        spacing: 10,
        children: [
          // Title row
          Row(
            children: [
              Text(
                title,
                style: GoogleFonts.urbanist(
                  color: const Color(0xff212121),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          // Stats icons row/wrap
          Builder(
            builder: (context) {
              final filteredWidgets = <Widget>[];

              for (int i = 0; i < icons.length; i++) {
                if (counts[i] > 0) {
                  filteredWidgets.add(
                    CircleWidget(
                      image: icons[i],
                      x: "${counts[i]}x",
                      title: labels[i],
                    ),
                  );
                }
              }

              if (filteredWidgets.isEmpty) {
                return const SizedBox.shrink();
              }

              if (filteredWidgets.length == 4) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: filteredWidgets,
                );
              }
              return Row(
                spacing: 20.w,
                children: filteredWidgets,
              );
            },
          ),
        ],
      ),
    );
  }
}

