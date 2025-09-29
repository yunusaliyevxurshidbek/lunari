import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> menstrualCyclePhases = [
  {
    "title": "menstrual".tr(),
    "subtitle": "what_happens".tr(),
    "color": const Color(0xffFF699C),
    "back_color": const Color(0xffFFCCCC),
    "image": "assets/icons/organ.svg",
    "happens":"menstrual_phase_text_1".tr(),
    "symptoms": "symptoms:_text".tr(),
    "chances": "fertilization_text".tr(),
    "chances_level": 1
  },
  {
    "title": "follicular_phase".tr(),
    "subtitle": "future_phase".tr(),
    "color": const Color(0xff00A9F1),
    "back_color": const Color(0xffCCCCFF),
    "image": "assets/icons/organ2.svg",
    "happens": "follicular_text_1".tr(),
    "symptoms": "follicular_text_2".tr(),
    "chances": "follicular_text_3".tr(),
    "chances_level": 2
  },
  {
    "title": "ovulation_phase".tr(),
    "subtitle": "",
    "color": const Color(0xffFFC02D),
    "back_color": const Color(0xffFFCC99),
    "image": "assets/icons/organ3.svg",
    "happens":"ovulation_text_1".tr(),
    "symptoms":"ovulation_text_2".tr(),
    "chances": "ovulation_text_3".tr(),
    "chances_level": 3
  },
  {
    "title": "luteal".tr(),
    "subtitle": "",
    "color": const Color(0xff4AAF57),
    "back_color": const Color(0xff99C5C4),
    "image": "assets/icons/organ4.svg",
    "happens":"luteal_text_1".tr(),
    "symptoms":"luteal_text_2".tr(),
    "chances": "luteal_text_3".tr(),
    "chances_level": 1
  }
];
