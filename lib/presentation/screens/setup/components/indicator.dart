import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lunari/core/utils/context_extention.dart';

class Indicator extends StatelessWidget {
  const Indicator({super.key, required this.page});

  final int page;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 1.sw - 170,
      decoration: BoxDecoration(
          color: context.colors.onPrimary,
          borderRadius: BorderRadius.circular(10)),
      alignment: Alignment.centerLeft,
      child: Container(
        width: (1.sw - 170) * (page + 1) / 8,
        height: 12,
        decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  offset: const Offset(1, 1),
                  blurRadius: 3,
                  spreadRadius: 0,
                  color: Colors.black.withOpacity(0.1))
            ],
            color: context.colors.primary,
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
