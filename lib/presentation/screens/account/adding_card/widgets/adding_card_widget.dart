import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';

import 'expiry_date.dart';

class AddingCardWidget extends StatefulWidget {
  const AddingCardWidget({super.key});

  @override
  State<AddingCardWidget> createState() => _AddingCardWidgetState();
}

class _AddingCardWidgetState extends State<AddingCardWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_formatCardNumber);
  }

  void _formatCardNumber() {
    final text = _controller.text.replaceAll(' ', '');
    if (text.length > 16) {
      _controller.value = TextEditingValue(
        text: text.substring(0, 16),
        selection: const TextSelection.collapsed(offset: 16),
      );
      return;
    }

    String newText = '';
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        newText += ' ';
      }
      newText += text[i];
    }

    if (_controller.text != newText) {
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [

        // card_field:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              "card_number".tr(),
              style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w600,
                color: context.colors.scrim,
                fontSize: 20.sp,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: context.colors.outline,
              ),
              child: TextField(
                controller: _controller,
                maxLines: 1,
                maxLength: 19,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(19),
                ],
                showCursor: false,
                decoration: InputDecoration(
                  hintText: "card_number".tr(),
                  hintStyle: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: context.ccolors.greyScale600,
                  ),
                  border: InputBorder.none,
                  counterText: "",
                ),
              ),
            ),
          ],
        ),

        // name:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              "account_holder_name".tr(),
              style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w600,
                color: context.colors.scrim,
                fontSize: 20.sp,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: context.colors.outline,
              ),
              child: TextField(
                maxLines: 1,
                showCursor: false,
                decoration: InputDecoration(
                  hintText: "name".tr(),
                  hintStyle: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: context.ccolors.greyScale600,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),

        Row(
          spacing: 15,
          children: [

            // expiry_date:
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "expiry_date".tr(),
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w600,
                      color: context.colors.scrim,
                      fontSize: 20.sp,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: context.colors.outline,
                    ),
                    child: TextField(
                      maxLines: 1,
                      showCursor: false,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        ExpiryDate(), // Custom formatter
                      ],
                      decoration: InputDecoration(
                        hintText: "MM/YY".tr(),
                        hintStyle: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: context.ccolors.greyScale600,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
              
              
              
              
                ],
              ),
            ),

            // cv_field:
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "cvv".tr(),
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w600,
                      color: context.colors.scrim,
                      fontSize: 20.sp,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: context.colors.outline,
                    ),
                    child: TextField(
                      maxLines: 1,
                      showCursor: false,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      decoration: InputDecoration(
                        hintText: "cvv".tr(),
                        hintStyle: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: context.ccolors.greyScale600,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),




                ],
              ),
            ),

          ],
        ),

        Divider(
          thickness: 1,
          color: context.ccolors.dividerLight,
        ),

        Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "supported_payments".tr(),
              style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w600,
                color: context.colors.scrim,
                fontSize: 20.sp,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/mastercard-2.svg",
                  height: 25,
                  width: 25,
                ),
                SvgPicture.asset(
                  "assets/icons/visa-2.svg",
                  height: 16,
                  width: 16,
                ),
                SvgPicture.asset(
                  "assets/icons/amazon.svg",
                  height: 25,
                  width: 25,
                ),
                SvgPicture.asset(
                  "assets/icons/american-2.svg",
                  height: 30,
                  width: 30,
                ),
                SvgPicture.asset(
                  "assets/icons/jcb.svg",
                  height: 30,
                  width: 30,
                ),
              ],
            ),
          ],
        ),

      ],
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_formatCardNumber);
    _controller.dispose();
    super.dispose();
  }
}