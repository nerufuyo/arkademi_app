import 'package:flutter/material.dart';

class AppTypographies {
  static const String fontFamily = 'Exo2';

  final TextStyle headline1 = const TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );

  final TextStyle headline2 = const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );

  final TextStyle headline3 = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );

  final TextStyle headline4 = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );

  final TextStyle headline5 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );

  final TextStyle headline6 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );

  final TextStyle bodyText1 = const TextStyle(
    fontSize: 16,
    fontFamily: fontFamily,
  );

  final TextStyle bodyText2 = const TextStyle(
    fontSize: 14,
    fontFamily: fontFamily,
  );

  final TextStyle subtitle1 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );

  final TextStyle subtitle2 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );

  final TextStyle button = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );

  final TextStyle caption = const TextStyle(
    fontSize: 12,
    fontFamily: fontFamily,
  );
}

class AppColors {
  Color primary = const Color(0xFF2163af);
  Color white = const Color(0xFFFFFFFF);
  Color success = const Color(0xFF4caf50);
  Color warning = const Color(0xFFff9800);
  Color error = const Color(0xFFf44336);
}

class AppSizes {
  static const double borderRadius = 8;
  static const double padding = 16;
  static const double margin = 16;
  static const double iconSize = 24;
  static const double iconSizeSmall = 16;
  static const double iconSizeLarge = 32;
  static const double textFontSize = 16;
  static const double textFontSizeSmall = 14;
  static const double textFontSizeLarge = 20;
  static const double textFontSizeExtraLarge = 24;
}
