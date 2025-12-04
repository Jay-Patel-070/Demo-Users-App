import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.whitecolor,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.whitecolor),
    iconTheme: IconThemeData(color: AppColors.blackcolor),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.greywithshade.withValues(alpha: 0.2),
      filled: true,
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionHandleColor: AppColors.blackcolor,
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(color: AppColors.blackcolor),
      bodyMedium: TextStyle(color: AppColors.blackcolor),
      bodyLarge: TextStyle(color: AppColors.blackcolor),
      titleMedium: TextStyle(color: AppColors.blackcolor),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.whitecolor,
    ),
    expansionTileTheme: ExpansionTileThemeData(
      iconColor: AppColors.blackcolor,
      collapsedIconColor: AppColors.blackcolor,
    ),
    dialogTheme: DialogThemeData(
      titleTextStyle: TextStyle(
        color: AppColors.primarycolor,
        fontSize: AppFontSizes.display,
        fontFamily: Appfonts.robotobold
      ),
      contentTextStyle: TextStyle(
        color: AppColors.blackcolor,
          fontSize: AppFontSizes.md,
          fontFamily: Appfonts.roboto
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      refreshBackgroundColor: AppColors.whitecolor,
    )
  );
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.blackcolor,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.blackcolor),
    iconTheme: IconThemeData(color: AppColors.whitecolor),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.greywithshade.withValues(alpha: 0.2),
      filled: true,
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(color: AppColors.whitecolor),
      bodyMedium: TextStyle(color: AppColors.whitecolor),
      bodyLarge: TextStyle(color: AppColors.whitecolor),
      titleMedium: TextStyle(color: AppColors.whitecolor),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.blackcolor,
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionHandleColor: AppColors.whitecolor,
    ),
    expansionTileTheme: ExpansionTileThemeData(
      iconColor: AppColors.whitecolor,
      collapsedIconColor: AppColors.whitecolor,
    ),
    popupMenuTheme: PopupMenuThemeData(
      // color: AppColors.blackcolor.withValues(alpha: 0.8),
    ),
      dialogTheme: DialogThemeData(
        // shape: RoundedRectangleBorder(
        //   borderRadius: .circular(AppRadius.md),
        //   side: BorderSide(
        //     color: AppColors.greywithshade
        //   )
        // ),
        //   backgroundColor: AppColors.blackcolor,
          titleTextStyle: TextStyle(
              color: AppColors.primarycolor,
              fontSize: AppFontSizes.display,
              fontFamily: Appfonts.robotobold
          ),
          contentTextStyle: TextStyle(
              color: AppColors.whitecolor,
              fontSize: AppFontSizes.md,
              fontFamily: Appfonts.roboto
          )
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        refreshBackgroundColor: AppColors.blackcolor,
      )
  );
}
