import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryPeriod extends StatefulWidget {
  final String day;
  final String number;
  final double degree;

  const HistoryPeriod(
      {super.key,
      required this.day,
      required this.number,
      required this.degree});

  @override
  State<HistoryPeriod> createState() => _HistoryPeriodState();
}

class _HistoryPeriodState extends State<HistoryPeriod> {
  DateTime selectedDate = DateTime.now();

  String getDate() {
    DateTime startOfWeek =
        selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    String formattedStart = DateFormat("MMM d").format(startOfWeek);
    String formattedEnd = DateFormat("MMM d, y").format(endOfWeek);

    return "$formattedStart - $formattedEnd";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        spacing: 10,
        children: [
          // Date:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getDate(),
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF212121),
                  fontSize: 17.sp,
                ),
              ),
              Text(
                widget.day,
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF212121),
                  fontSize: 17.sp,
                ),
              )
            ],
          ),

          // Graphic:
          SizedBox(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 16,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        const Color(0xFFEEEEEE),
                        const Color(0xFFEEEEEE),
                        const Color(0x15FF699C).withOpacity(0.2),
                      ],
                      stops: const [0.0, 0.65, 1.0],
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 75,
                      height: 16,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                        color: const Color(0xFFFF699C),
                      ),
                      child: Text(
                        widget.number,
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFFFFFFF),
                            fontSize: 12.sp,
                            height: 1.6),
                      ),
                    ),
                    SizedBox(
                        width:
                            MediaQuery.of(context).size.width * widget.degree),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1000),
                            color: const Color(0xFFFFC02D),
                          ),
                        ),
                        Positioned(
                            right: 10,
                            child: SvgPicture.asset(
                              "assets/icons/ovul.svg",
                            )),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
