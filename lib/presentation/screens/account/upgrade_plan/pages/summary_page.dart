import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/screens/account/upgrade_plan/pages/success_page.dart';
import '../../../../../data/models/card_model.dart';
import '../widgets/upgrade_text.dart';


class SummaryPage extends StatefulWidget {
  final CardInfo selectedCard;
  const SummaryPage({super.key, required this.selectedCard});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {

  bool isCardSelected = false;

  callPaymentPage() {
    Navigator.pop(context);
  }

  callSuccessPage(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SuccessPage()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onSecondary,
      appBar: AppBar(
        backgroundColor: context.colors.onSecondary,
        title: Text(
          "review_summary".tr(),
          style: GoogleFonts.urbanist(
              fontSize: 24.sp,
              color: const Color(0xff212121),
              height: 1.4,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24, top: 15, bottom: 15),
          child: GestureDetector(
            onTap: () {
              callPaymentPage();
            },
            child: SvgPicture.asset(
              "assets/icons/arrow_left_long.svg",
              height: 28,
              width: 28,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: context.colors.onPrimary,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                width: 1, color: context.colors.onPrimary),
                          ),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "lunari_pro".tr(),
                                    style: GoogleFonts.urbanist(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.sp,
                                      color: context.colors.scrim,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 30,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          r"$49.99 / ",
                                          style: GoogleFonts.urbanist(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 30.sp,
                                            color: context.colors.scrim,
                                          ),
                                        ),
                                        Text(
                                          "year".tr(),
                                          style: GoogleFonts.urbanist(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.sp,
                                            color: context.colors.scrim,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Divider(
                                    thickness: 1,
                                    color: context.ccolors.dividerLight,
                                  ),
                                  const UpgradeText(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 65,
                            height: 25,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: context.colors.primary,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              spacing: 5,
                              children: [
                                Text(
                                  "save".tr(),
                                  style: GoogleFonts.urbanist(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                    color: context.colors.onPrimary,
                                  ),
                                ),
                                Text(
                                  " 16%".tr(),
                                  style: GoogleFonts.urbanist(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                    color: context.colors.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "selected_payment_method".tr(),
                      style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w600,
                        color: context.colors.scrim,
                        fontSize: 15.sp,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.only(left: 10, bottom: 12, top: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1,
                          color: isCardSelected ? context.colors.primary : context.colors.onPrimary,
                        ),
                        color: context.colors.onPrimary,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                            AssetImage(widget.selectedCard.imageUrl),
                          ),
                          const SizedBox(width: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.selectedCard.name.tr(),
                                style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w700,
                                  color: context.colors.scrim,
                                  fontSize: 18.sp,
                                ),
                              ),
                              Text(
                                widget.selectedCard.email.tr(),
                                style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w400,
                                  color: context.colors.greyScale700,
                                  fontSize: 14.sp,
                                ),
                              )
                            ],
                          ),
                          TextButton(
                            onPressed: (){
                              callPaymentPage();
                            },
                            child: Text("change".tr(),style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.w700,
                              color: context.colors.primary,
                              fontSize: 12.sp,
                            ),),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            color: context.colors.onPrimary,
            child: GestureDetector(
              onTap: () {
                callSuccessPage();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  color: context.colors.primary,
                ),
                child: Text(
                  "confirm_payment".tr(),
                  style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w700,
                    color: context.colors.onPrimary,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}