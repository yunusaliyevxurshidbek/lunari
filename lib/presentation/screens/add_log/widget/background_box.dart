import 'package:flutter/material.dart';

class BackgroundBox extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;

  const BackgroundBox({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: color ?? Theme.of(context).colorScheme.onPrimary,
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
