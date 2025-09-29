import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunari/core/utils/context_extention.dart';
import '../pages/contact_support.dart';
import '../pages/faq_page.dart';
import '../pages/privacy_policy.dart';
import '../pages/terms_service.dart';
import 'list_of_texts.dart';


class SupportWidget extends StatefulWidget {
  const SupportWidget({super.key});

  @override
  State<SupportWidget> createState() => _SupportWidgetState();
}

class _SupportWidgetState extends State<SupportWidget> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        spacing: 20,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: context.colors.onPrimary,
            ),
            child: Column(
              spacing: 15,
              children: [
                ListOfTexts(name: "faq",page: () => const FaqPage(),),
                ListOfTexts(name: "contact_support", page: () => const ContactSupport(),),
                ListOfTexts(name: "privacy_policy",page: () => const PrivacyPolicy(),),
                ListOfTexts(name: "terms_service",page: () => const TermsService(),),
                ListOfTexts(name: "partner",page: () => const FaqPage(),),
                ListOfTexts(name: "job_vacancy",page: () => const FaqPage(),),
                ListOfTexts(name: "accessibility",page: () => const FaqPage(),),
                ListOfTexts(name: "feedback",page: () => const FaqPage(),),
                ListOfTexts(name: "about_us",page: () => const FaqPage(),),
                ListOfTexts(name: "rate_us",page: () => const FaqPage(),),
                ListOfTexts(name: "visit_our_website",page: () => const FaqPage(),),
                ListOfTexts(name: "follow_social_media",page: () => const FaqPage(),),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
