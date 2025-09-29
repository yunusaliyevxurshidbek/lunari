import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoItem extends StatelessWidget {
  const InfoItem({super.key, required this.item, required this.index});

  final Map<String, dynamic> item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: const Color(0xffF5F5F5)),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                margin: const EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                    color: item["color"],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6))),
                alignment: Alignment.center,
                child: Text(
                  "${index + 1}",
                  style: GoogleFonts.urbanist(
                      color: const Color(0xffFFFFFF),
                      fontSize: 16.sp,
                      height: 1.6,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 115.w,
                child: Text(
                  tr(item["title"]),
                  style: GoogleFonts.urbanist(
                      fontSize: 16.sp,
                      color: const Color(0xff212121),
                      fontWeight: FontWeight.bold,
                      height: 1.6,
                      letterSpacing: 1.2),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              )
            ],
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 100,
                height: 100,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color: const Color(0xffEEEEEE),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    Positioned(
                        child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 100,
                      child: SvgPicture.asset(item["image"]),
                    ))
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
