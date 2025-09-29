class SplashState {
  final int currentPage;

  SplashState ({ required this.currentPage });

  SplashState copyWith ({int? currentPage})
  {
    return SplashState(
      currentPage: currentPage ?? this.currentPage
    );
  }
}
