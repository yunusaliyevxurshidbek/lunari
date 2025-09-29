import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lunari/core/router/app_router.dart';
import 'package:lunari/presentation/blocs/splash/splash_event.dart';
import 'package:lunari/presentation/blocs/splash/splash_state.dart';

import '../../../core/constants/splash.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final PageController pageController;

  SplashBloc()
      : pageController = PageController(initialPage: 0, keepPage: true),
        super(SplashState(currentPage: 0)) {
    on<PageChanged>((event, emit) {
      emit(state.copyWith(currentPage: event.pageIndex));
    });

    on<ContinuePressed>((event, emit) {
      final nextPage = state.currentPage + 1;
      if (nextPage < splash.length) {
        pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        emit(state.copyWith(currentPage: nextPage));
      }
    });

    on<SkipPressed>((event, emit) async {
      while (event.context.canPop()) {
        event.context.pop();
      }
      event.context.go("/loading");
    });

    on<StartPressed>((event, emit) async {
      event.context.push(AppRouter.auth);
    });
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
