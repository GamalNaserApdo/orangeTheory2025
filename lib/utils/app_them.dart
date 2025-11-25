import 'package:flutter/material.dart';
import 'package:otfksa2/utils/app_colors.dart';
import 'package:otfksa2/utils/app_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.whiteColor,
    indicatorColor: AppColors.blackColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: AppBarTheme(
      // backgroundColor: AppColors.whiteColor,
      iconTheme: IconThemeData(color: AppColors.whiteColor),
      centerTitle: true,
      color: AppColors.transparentColor,
    ),
    textTheme: TextTheme(
      labelLarge: AppStyles.bold16Black,
      labelSmall: AppStyles.medium12Gray,
      labelMedium: AppStyles.medium14Black,
      headlineMedium: AppStyles.medium20Black,
      headlineLarge: AppStyles.medium24Black,
      bodyLarge: AppStyles.medium24Black,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.blackColor,
    indicatorColor: AppColors.whiteColor,
    scaffoldBackgroundColor: AppColors.blackColor,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      // backgroundColor: AppColors.blackColor,
      iconTheme: IconThemeData(color: AppColors.whiteColor),
      color: AppColors.blackColor,
    ),
    textTheme: TextTheme(
      labelLarge: AppStyles.bold16White,
      labelMedium: AppStyles.medium14White,
      labelSmall: AppStyles.medium12Gray,
      headlineMedium: AppStyles.medium20White,
      headlineLarge: AppStyles.bold24White,
      bodyLarge: AppStyles.medium24White,
    ),
  );
}
