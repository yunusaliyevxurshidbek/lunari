import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';


class ListOfTexts extends StatefulWidget {
  final String name;
  final Widget Function() page;
  const ListOfTexts({super.key, required this.name, required this.page});

  @override
  State<ListOfTexts> createState() => _ListOfTextsState();
}

class _ListOfTextsState extends State<ListOfTexts> {

  callDirectedPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget.page()),
    );

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        callDirectedPage();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 10,
        children: [
          Text(widget.name.tr(),style: GoogleFonts.urbanist(
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            color: context.colors.scrim,
          ),),
          SvgPicture.asset(
            "assets/icons/arrow_right.svg",
            height: 20,
            width: 20,
            color: context.colors.scrim,
          )
        ],
      ),
    );
  }
}
