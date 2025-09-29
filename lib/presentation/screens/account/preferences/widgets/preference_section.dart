import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:lunari/presentation/screens/account/preferences/widgets/preferences_row.dart';
import '../../../../../data/models/perferences_model.dart';

class PreferenceSection extends StatelessWidget {
  final List<PreferenceItem> items;
  const PreferenceSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: context.colors.onPrimary,
      ),
      child: Column(
        spacing: 15,
        children: items.map((item) =>
            GestureDetector(
              onTap: item.onTap,
              child: PreferenceRow(item: item),
            )
        ).toList(),
      ),
    );
  }
}