import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import '../../widgets/custom_button.dart';

class SwitchCup extends StatefulWidget {
  const SwitchCup({super.key});

  @override
  State<SwitchCup> createState() => _SwitchCupState();
}

class _SwitchCupState extends State<SwitchCup> {
  final List<Map<String, dynamic>> cups = [
    {"icon": "assets/images/100ml.png", "amount": 100},
    {"icon": "assets/images/125ml.png", "amount": 125},
    {"icon": "assets/images/150ml.png", "amount": 150},
    {"icon": "assets/images/200ml.png", "amount": 200},
    {"icon": "assets/images/250ml.png", "amount": 250},
    {"icon": "assets/images/300ml.png", "amount": 300},
    {"icon": "assets/images/350ml.png", "amount": 350},
    {"icon": "assets/images/400ml.png", "amount": 400},
    {"icon": "assets/images/500ml.png", "amount": 500},
    {"icon": "assets/images/600ml.png", "amount": 600},
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("switch_cup".tr(),
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w700, fontSize: 25.sp,color: context.colors.scrim),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pop(context);
          },
          icon: SvgPicture.asset(
              "assets/icons/remove.svg"
          ),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: cups.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected
                          ? context.ccolors.blue
                          : context.ccolors.dividerLight,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Image.asset(cups[index]["icon"]),
                ),
                Text(
                  "${cups[index]["amount"]} ml".tr(),
                  style: GoogleFonts.urbanist(
                    color: isSelected
                        ? context.ccolors.blue
                        : context.ccolors.greyScale,
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding:
        const EdgeInsets.only(top: 18, bottom: 16, left: 24, right: 24),
        decoration: const BoxDecoration(color: Colors.white),
        child: CustomButton(
          text: "ok".tr(),
          onClick: () {
            if (selectedIndex != null) {
              Navigator.pop(context, {
                "amount": cups[selectedIndex!]["amount"],
                "icon": cups[selectedIndex!]["icon"]
              });
            }
          },
          color: Colors.white,
          bgColor: context.ccolors.blue,
        ),
      ),
    );
  }
}


