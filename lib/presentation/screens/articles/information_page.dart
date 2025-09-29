import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:share_plus/share_plus.dart';
import '../../../data/models/article_model.dart';


class InformationPage extends StatelessWidget {
  final HealthItem item;
  const InformationPage({super.key, required this.item, });

  void callArticlePage(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onPrimary,
      appBar: AppBar(
        backgroundColor: context.colors.onPrimary,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24, top: 15, bottom: 15),
          child: GestureDetector(
            onTap: () {
              callArticlePage(context);
            },
            child: SvgPicture.asset(
              "assets/icons/arrow_left_long.svg",
              height: 28,
              width: 28,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: GestureDetector(
              onTap: () async {
                final shareText = "${item.title.tr()}\n\n${item.content!.tr()}";
                final params = ShareParams(
                  text: shareText,

                );
                final result = await SharePlus.instance.share(params);
                if (result.status == ShareResultStatus.success) {
                } else {
                }
              },
              child: SvgPicture.asset(
                "assets/icons/share.svg",
                height: 25,
                width: 25,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // header:
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      item.title.tr(),
                      style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w700,
                        fontSize: 25.sp,
                        color: context.colors.scrim,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  Expanded(
                    child: SvgPicture.asset(
                      item.icon,
                      height: 80,
                      width: 75,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              Text("published_on".tr(),style: GoogleFonts.urbanist(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: context.colors.greyScale700,
              ),),

              Divider(
                color: context.colors.dividerLight,
                thickness: 1,
              ),

              // content:
              Text(
                item.content!.tr(),
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: context.colors.greyScale,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
