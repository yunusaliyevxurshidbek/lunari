import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/utils/context_extention.dart';
import '../../../../core/constants/menu.dart';
import '../../../core/router/app_router.dart';
import 'components/subscription_banner.dart';
import 'components/user_panel.dart';
import 'logout/logout.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late final List<Map<String, String>> accountMenu;

  @override
  void initState() {
    super.initState();
    accountMenu = [
      {"key": "preferences", "icon": "assets/icons/settings.svg", "url": AppRouter.preferences},
      {"key": "reminder", "icon": "assets/icons/clock.svg", "url": AppRouter.reminder},
      {"key": "invite_friends", "icon": "assets/icons/user_group.svg", "url": AppRouter.inviteFriend},
      {"key": "account_security", "icon": "assets/icons/shield.svg", "url": AppRouter.security},
      {"key": "payment_methods", "icon": "assets/icons/card.svg", "url": AppRouter.paymentmethods},
      {"key": "billing_subscription", "icon": "assets/icons/billing.svg", "url": AppRouter.subscription},
      {"key": "linked_accounts", "icon": "assets/icons/linked.svg", "url": AppRouter.linkedacounts},
      {"key": "data_analytcis", "icon": "assets/icons/data.svg", "url": AppRouter.analytics},
      {"key": "app_appearance", "icon": "assets/icons/eye.svg", "url": AppRouter.appearance},
      {"key": "help_support", "icon": "assets/icons/support.svg", "url": AppRouter.support},
      {"key": "rate_us", "icon": "assets/icons/star.svg", "url": "/gallery"},
      {"key": "logout", "icon": "assets/icons/logout.svg", "url": "/logout"},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onSecondary,
      appBar: AppBar(
        surfaceTintColor: context.colors.onSecondary,
        backgroundColor: context.colors.onSecondary,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24, top: 15, bottom: 15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: Image.asset(
              "assets/images/logo_filled.png",
              fit: BoxFit.contain,
              width: 22.w,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'account'.tr(),
          style: GoogleFonts.urbanist(
            fontSize: 24.sp,
            color: const Color(0xff212121),
            height: 1.4,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: SvgPicture.asset("assets/icons/dots.svg"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: Column(
          children: <Widget>[
            const SubscriptionBanner(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: UserPanel(),
            ),
            Container(
              width: 1.sw,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: accountMenu.map((e) {
                  final isLogout = e['key'] == 'logout';
                  return ListTile(
                    dense: true,
                    onTap: () {
                      if (isLogout) {
                        LogoutBottomSheet.show(context);
                      } else {
                        context.push(e['url']!);
                      }
                    },
                    leading: SvgPicture.asset(
                      e['icon']!,
                      width: 24.w,
                    ),
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      e['key']!.tr(),
                      style: GoogleFonts.urbanist(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: isLogout ? const Color(0xffF75555) : const Color(0xff212121),
                      ),
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      size: 32.sp,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
