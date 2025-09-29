import 'package:flutter/material.dart';

import '../../../core/dependency/dependency.dart';


class MyAppScope extends StatefulWidget {
  const MyAppScope({
    super.key,
    required this.dependency,
    required this.child,
  });

  final Widget child;
  final AppDependency dependency;

  @override
  State<MyAppScope> createState() => MyAppScopeState();
}

class MyAppScopeState extends State<MyAppScope> {
  late final AppDependency dependency;

  @override
  void initState() {
    super.initState();
    dependency = widget.dependency;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}