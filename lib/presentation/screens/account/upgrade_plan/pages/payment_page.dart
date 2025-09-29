import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/screens/account/upgrade_plan/pages/summary_page.dart';
import '../../../../../data/datasources/fake/card_data.dart';
import '../../../../../data/models/card_model.dart';
import '../widgets/card_widget.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  CardInfo? selectedCard;

  callSubscriptionPages() {
    Navigator.pop(context);
  }

  callSummaryPage() {
    if ( selectedCard == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: context.colors.errorContainer,
          content: Text("Select a payment method!".tr(),style: GoogleFonts.urbanist(
            color: context.colors.error,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),),
        )
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SummaryPage(selectedCard: selectedCard!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onSecondary,
      appBar: AppBar(
        backgroundColor: context.colors.onSecondary,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24, top: 15, bottom: 15),
          child: GestureDetector(
            onTap: () {
              callSubscriptionPages();
            },
            child: SvgPicture.asset(
              "assets/icons/arrow_left_long.svg",
              fit: BoxFit.contain,
              width: 22,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "choose_payment_methods".tr(),
          style: GoogleFonts.urbanist(
              fontSize: 20.sp,
              color: const Color(0xff212121),
              height: 1.4,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: InkWell(
              child: SvgPicture.asset("assets/icons/plus.svg"),
            ),
          )
        ],
      ),

      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(left:24,top:24, right:24,bottom:80),
            itemCount: CardData.cards.length,
            itemBuilder: (context, index) {
              final card = CardData.cards[index];
              return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCard = card;
                      });
                    },
                    child: CardWidget(
                      card: card,
                      isSelected: selectedCard == card,
                    ),
                  )
              );
            },
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: context.colors.onPrimary,
              child: GestureDetector(
                onTap: () {
                  callSummaryPage();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: context.colors.primary,
                  ),
                  child: Text(
                    "continue".tr(),
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w700,
                      color: context.colors.onPrimary,
                      fontSize: 14.sp,
                    ),
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