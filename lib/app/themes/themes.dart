import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/themes/colors.dart';

class AppTheme {
  static final _fabThemeData = FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    accentColor: primary,
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      color: bgLight,
      elevation: 0,
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.black87, fontSize: 20),
      ),
    ),
    brightness: Brightness.light,
    primaryColor: primary,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: bgLight,
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Nunito Sans',
        ),
    primaryTextTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Nunito Sans',
        ),
    accentTextTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Nunito Sans',
        ),
    floatingActionButtonTheme: _fabThemeData,
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    accentColor: primary,
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      color: bgDark,
      elevation: 0,
    ),
    brightness: Brightness.dark,
    cardColor: bgDarkSecondary,
    indicatorColor: bgDark,
    primaryColor: primary,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: bgDark,
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Nunito Sans',
          bodyColor: textLight,
          displayColor: textLight,
          decorationColor: textLight,
        ),
    primaryTextTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Nunito Sans',
          bodyColor: textLight,
        ),
    accentTextTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Nunito Sans',
          bodyColor: textLight,
        ),
    iconTheme: IconThemeData(color: textLight),
    floatingActionButtonTheme: _fabThemeData,
  );
}
