import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';
import '../../../../data/datasources/fake/card_data.dart';
import '../adding_card/adding_card.dart';
import '../upgrade_plan/widgets/card_widget.dart';



class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {


  callBack() {
    Navigator.pop(context);
  }

  callAddingCard() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddingCard()),
      );
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onSecondary,
      appBar: AppBar(
        backgroundColor: context.colors.onSecondary,
        title: Text(
          "payment_methods".tr(),
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
              callBack();
            },
            child: SvgPicture.asset(
              "assets/icons/arrow_left_long.svg",
              height: 28,
              width: 28,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 8),
            itemCount: CardData.cards.length,
          itemBuilder: (context,index){
            final card = CardData.cards[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CardWidget(
                card: card, isSelected: false,
              ),
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
                  callAddingCard();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: context.colors.primary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/plus.svg",
                        height: 15,
                        width: 15,
                        color: context.colors.onPrimary,
                      ),
                      Text(
                        "add_new_payment".tr(),
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w700,
                          color: context.colors.onPrimary,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
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