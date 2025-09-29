import 'package:flutter/cupertino.dart';

abstract class SplashEvent {}

class PageChanged extends SplashEvent {
  final int pageIndex;
  PageChanged(this.pageIndex);
}

class SkipPressed extends SplashEvent {
  final BuildContext context;
  SkipPressed(this.context);
}

class ContinuePressed extends SplashEvent {}

class StartPressed extends SplashEvent {
  final BuildContext context;
  StartPressed(this.context);
}