import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';

class ExpandableContainer extends StatefulWidget {
  final title;
  final info;
  const ExpandableContainer({super.key, this.title, this.info});

  @override
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colors.onPrimary,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 10,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: context.colors.onPrimary,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title.tr(),
                      style: GoogleFonts.urbanist(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: context.colors.scrim,
                      ),
                    ),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 300),
                      turns: isExpanded ? 0.5 : 0.0,
                      child: SvgPicture.asset(
                        "assets/icons/arrow_down.svg",
                        height: 20,
                        width: 20,
                        color: context.ccolors.greyScale700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (isExpanded)
              Divider(
                thickness: 1,
                color: context.ccolors.dividerLight,
              ),



            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              child: Visibility(
                visible: isExpanded,
                child: Text(
                  widget.info.tr(),
                  style: GoogleFonts.urbanist(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: context.ccolors.greyScale700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
