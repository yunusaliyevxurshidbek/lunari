import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({Key? key}) : super(key: key);

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  int? selectedIndex;
  late List<String> listOfLanguages;
  late List<Locale> locales;

  static const _prefsKey = 'selected_language_code';

  @override
  void initState() {
    super.initState();
    listOfLanguages = [
      'English', 'Spanish', 'Mandarin Chinese', 'Hindi', 'Arabic',
      'Bengali', 'Portuguese', 'Russian', 'Japanese', 'German',
      'French', 'Urdu',
    ];
    locales = [
      const Locale('en'), const Locale('es'), const Locale('zh'),
      const Locale('hi'), const Locale('ar'), const Locale('bn'),
      const Locale('pt'), const Locale('ru'), const Locale('ja'),
      const Locale('de'), const Locale('fr'), const Locale('ur'),

    ];
    _loadSelectedLanguage();
  }

  Future<void> _loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_prefsKey);
    final current = code != null ? Locale(code) : context.locale;
    final idx = locales.indexWhere((loc) => loc.languageCode == current.languageCode);
    setState(() {
      selectedIndex = idx >= 0 ? idx : 0;
    });
  }

  Future<void> _onLanguageTap(int index) async {
    final locale = locales[index];
    await context.setLocale(locale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, locale.languageCode);
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.colors.onPrimary,
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: listOfLanguages.length,
        separatorBuilder: (context, index) => Divider(
          thickness: 1,
          color: context.colors.dividerLight,
        ),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => _onLanguageTap(index),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    listOfLanguages[index].tr(),
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w600,
                      color: context.colors.scrim,
                      fontSize: 20.sp,
                    ),
                  ),
                  if (isSelected)
                    SvgPicture.asset(
                      'assets/icons/confirm.svg',
                      color: context.colors.primary,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

