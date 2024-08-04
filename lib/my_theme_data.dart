import 'package:flutter/material.dart';
import 'package:todo_app/app_colors.dart';
// import 'package:google_fonts/google_fonts.dart';

class MyThemeData{

  static final ThemeData LightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundLightColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      elevation: 0
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.greyColor,
      showUnselectedLabels: false,
      backgroundColor: Colors.transparent,
      elevation: 0
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft:  Radius.circular(20),
          topRight: Radius.circular(20)
        ),
        side: BorderSide(
          color: AppColors.whiteColor,
          width: 4
        )
      )
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: BorderSide(
          color: AppColors.whiteColor,
          width: 5,
        )
      )
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.whiteColor
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.blackColor
    ),
      bodyMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.blackColor
      ),
      bodySmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.blackColor
      ),
    )
  );
}