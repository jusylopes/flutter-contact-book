import 'package:flutter/material.dart';
import 'package:flutter_contact_book/utils/assets_manager.dart';
import 'package:flutter_contact_book/utils/colors.dart';
import 'package:flutter_contact_book/utils/no_transition_screen.dart';

abstract class AppTheme {
  static ThemeData get light => ThemeData(
      primarySwatch: AppColors.colorPrimarySwatch,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: AssetsManager.fontFamily,
      scaffoldBackgroundColor: AppColors.colorBackground,
      textTheme: _buildTextTheme(),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: NoTransitionsScreen(),
          TargetPlatform.iOS: NoTransitionsScreen(),
        },
      ),
      appBarTheme:
          const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ));

  static TextTheme _buildTextTheme() {
    return const TextTheme(
      titleLarge: TextStyle(
        fontSize: 26.0,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w300,
        color: Colors.black,
      ),
    );
  }
}
