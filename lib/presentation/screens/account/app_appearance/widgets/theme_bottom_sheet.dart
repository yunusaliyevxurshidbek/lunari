import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';

import '../../../../cubit/theme/theme_cubit.dart';


class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet<String>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
      ),
      isScrollControlled: true,
      builder: (context) => const ThemeBottomSheet(),
    );
  }

  @override
  _ThemeBottomSheetState createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  late String selectedTheme;

  final List<_ThemeItem> _themes = const [
    _ThemeItem(label: 'light', value: 'light'),
    _ThemeItem(label: 'dark', value: 'dark'),
    _ThemeItem(label: 'system_default', value: 'system'),
  ];

  @override
  void initState() {
    super.initState();
    final currentMode = context.read<ThemeCubit>().state;
    selectedTheme = currentMode == ThemeMode.light
        ? 'light'
        : currentMode == ThemeMode.dark
        ? 'dark'
        : 'system';
  }@override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 24.w,
        left: 24.w,
        top: 15.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 36.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'choose_theme'.tr(),
            style: GoogleFonts.urbanist(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: context.colors.scrim,
            ),
          ),
          SizedBox(height: 10.h),
          Divider(thickness: 1, color: context.colors.dividerLight),
          ..._themes.map((item) => _buildRadioTile(item)),
          Divider(thickness: 1, color: context.colors.dividerLight),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: context.colors.secondary,
                    ),
                    child: Text(
                      'cancel'.tr(),
                      style: GoogleFonts.urbanist(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: context.colors.primary,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    final cubit = context.read<ThemeCubit>();
                    switch (selectedTheme) {
                      case 'light':
                        cubit.setLight();
                        break;
                      case 'dark':
                        cubit.setDark();
                        break;
                      case 'system':
                      default:
                        cubit.setSystem();
                    }
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: context.colors.primary,
                    ),
                    child: Text(
                      'ok'.tr(),
                      style: GoogleFonts.urbanist(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: context.colors.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadioTile(_ThemeItem item) {
    return RadioListTile<String>(
      title: Text(
        item.label.tr(),
        style: GoogleFonts.urbanist(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: context.colors.scrim,
        ),
      ),
      value: item.value,
      groupValue: selectedTheme,
      onChanged: (val) => setState(() => selectedTheme = val!),
      activeColor: context.colors.primary,
    );
  }
}

class _ThemeItem {
  final String label;
  final String value;
  const _ThemeItem({required this.label, required this.value});
}

