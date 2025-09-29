import 'dart:ui';
import 'package:flutter/cupertino.dart';

class PreferenceItem {
  final String title;
  final String? value;
  final VoidCallback? onTap;
  final bool isSwitch;
  final bool? switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final bool hasBottomSheet;

  const PreferenceItem({
    required this.title,
    this.value,
    this.onTap,
    this.isSwitch = false,
    this.switchValue,
    this.onSwitchChanged,
    this.hasBottomSheet = false,
  });
}


class BottomSheetOption {
  final String title;
  final String value;
  final bool isSelected;

  const BottomSheetOption({
    required this.title,
    required this.value,
    this.isSelected = false,
  });
}

class BottomSheetConfig {
  final String title;
  final List<BottomSheetOption> options;
  final String currentValue;
  final ValueChanged<String> onSelected;

  const BottomSheetConfig({
    required this.title,
    required this.options,
    required this.currentValue,
    required this.onSelected,
  });
}