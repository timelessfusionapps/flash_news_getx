import 'package:flash_news_getx/constants/color_constants.dart';
import 'package:flutter/material.dart';

class Themes {
  static final appTheme = ThemeData(
    primaryColor: AppColors.burgundy,
    scaffoldBackgroundColor: AppColors.lightGrey,
    buttonTheme: const ButtonThemeData(buttonColor: AppColors.orangeWeb),
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.burgundy),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: AppColors.orangeWeb),
  );
}
