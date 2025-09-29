import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lunari/core/utils/context_extention.dart';

class DayNames extends StatelessWidget {
  const DayNames({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Sun".tr(),
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Text(
            "Mon".tr(),
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Text(
            "Tue".tr(),
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Text(
            "Wed".tr(),
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Text(
            "Thu".tr(),
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium,
          ),
        ),
        Expanded(
          child: Text(
            "Fri".tr(),
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Text(
            "Sat".tr(),
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
