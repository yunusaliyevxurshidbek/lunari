import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  Color get greyScale => const Color(0xFF424242);
  Color get greyScale700 => const Color(0xFF616161);
  Color get dividerLight => const Color(0xFFEEEEEE);
  Color get component => const Color(0xFF9E9E9E);
  Color get surface => const Color(0xFFFF981F);
  Color get greyScale600 => const Color(0xFF757575);
  Color get textLight => const Color(0xFFBDBDBD);
  Color get alert => const Color(0xFFF75555);
  Color get blue => const Color(0xFF1A96F0);
  Color get darkBlue => const Color(0xFF1578C0);
  Color get border => const Color(0xFFE0E0E0);
  Color? get grey200 =>  Colors.grey[200];

}
extension ContextExtensions on BuildContext {
  ColorScheme get ccolors => Theme.of(this).colorScheme;
}


class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    fontFamily: "Poppins",
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    fontFamily: "Poppins",
  );
}

ColorScheme lightColorScheme = const ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFff699c),
  secondary: Color(0xFFFFF3F7),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFD0E4FF),
  onPrimaryContainer: Color(0xFF000000),
  primaryFixed: Color(0xFFBFD9ED),
  primaryFixedDim: Color(0xFF8CB7DA),
  onPrimaryFixed: Color(0xFF000D16),
  onPrimaryFixedVariant: Color(0xFF001629),
  onSecondary: Color(0xffF5F5F5),
  secondaryContainer: Color(0xFFFFDBCF),
  onSecondaryContainer: Color(0xFF000000),
  secondaryFixed: Color(0xFFF5CFC1),
  secondaryFixedDim: Color(0xFFE6A78F),
  onSecondaryFixed: Color(0xFF371002),
  onSecondaryFixedVariant: Color(0xFF481603),
  tertiary: Color(0xFF006875),
  onTertiary: Color(0xFFEEEEEE),
  tertiaryContainer: Color(0xFF95F0FF),
  onTertiaryContainer: Color(0xFF000000),
  tertiaryFixed: Color(0xFFBFE6EB),
  tertiaryFixedDim: Color(0xFF8CCED6),
  onTertiaryFixed: Color(0xFF000D0E),
  onTertiaryFixedVariant: Color(0xFF001D20),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFFDAD6),
  onErrorContainer: Color(0xFF000000),
  surface: Color(0xFFFCFCFC),
  onSurface: Color(0xFF111111),
  surfaceDim: Color(0xFFE0E0E0),
  surfaceBright: Color(0xFFFDFDFD),
  surfaceContainerLowest: Color(0xFFFFFFFF),
  surfaceContainerLow: Color(0xFFF8F8F8),
  surfaceContainer: Color(0xFFF3F3F3),
  surfaceContainerHigh: Color(0xFFEDEDED),
  surfaceContainerHighest: Color(0xFFE7E7E7),
  onSurfaceVariant: Color(0xFF393939),
  outline: Color(0xFFFAFAFA),
  outlineVariant: Color(0xFFD1D1D1),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF212121),
  inverseSurface: Color(0xFF2A2A2A),
  onInverseSurface: Color(0xFFF1F1F1),
  inversePrimary: Color(0xFF92C5EE),
  surfaceTint: Color(0xFF004881),
);

ColorScheme darkColorScheme = const ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFff699c),
  onPrimary: Color(0xFF000000),
  primaryContainer: Color(0xFF00325B),
  onPrimaryContainer: Color(0xFFFFFFFF),
  primaryFixed: Color(0xFFBFD9ED),
  primaryFixedDim: Color(0xFF8CB7DA),
  onPrimaryFixed: Color(0xFF000D16),
  onPrimaryFixedVariant: Color(0xFF001629),
  secondary: Color(0xFFFFB59D),
  onSecondary: Color(0xFF000000),
  secondaryContainer: Color(0xFF872100),
  onSecondaryContainer: Color(0xFFFFFFFF),
  secondaryFixed: Color(0xFFF5CFC1),
  secondaryFixedDim: Color(0xFFE6A78F),
  onSecondaryFixed: Color(0xFF371002),
  onSecondaryFixedVariant: Color(0xFF481603),
  tertiary: Color(0xFF86D2E1),
  onTertiary: Color(0xFF000000),
  tertiaryContainer: Color(0xFF004E59),
  onTertiaryContainer: Color(0xFFFFFFFF),
  tertiaryFixed: Color(0xFFBFE6EB),
  tertiaryFixedDim: Color(0xFF8CCED6),
  onTertiaryFixed: Color(0xFF000D0E),
  onTertiaryFixedVariant: Color(0xFF001D20),
  error: Color(0xFFFFB4AB),
  onError: Color(0xFF000000),
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFFFFF),
  surface: Color(0xFF080808),
  onSurface: Color(0xFFF1F1F1),
  surfaceDim: Color(0xFF060606),
  surfaceBright: Color(0xFF2C2C2C),
  surfaceContainerLowest: Color(0xFF010101),
  surfaceContainerLow: Color(0xFF0E0E0E),
  surfaceContainer: Color(0xFF151515),
  surfaceContainerHigh: Color(0xFF1D1D1D),
  surfaceContainerHighest: Color(0xFF282828),
  onSurfaceVariant: Color(0xFFCACACA),
  outline: Color(0xFF777777),
  outlineVariant: Color(0xFF414141),
  shadow: Color(0xFF000000),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFFE8E8E8),
  onInverseSurface: Color(0xFF2A2A2A),
  inversePrimary: Color(0xFF4A5A6B),
  surfaceTint: Color(0xFF9FC9FF),
);
