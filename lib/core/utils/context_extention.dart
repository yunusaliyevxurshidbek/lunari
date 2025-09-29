import 'package:flutter/material.dart';

import '../../../core/dependency/dependency.dart';
import '../../presentation/widgets/my_app_scope.dart';

extension ContextExtension on BuildContext {

  ColorScheme get colors => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  AppDependency get dependencies =>
      findAncestorStateOfType<MyAppScopeState>()!.dependency;
}