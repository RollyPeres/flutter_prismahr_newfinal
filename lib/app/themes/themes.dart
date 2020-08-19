import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/themes/colors.dart';

class AppTheme {
  static ShapeBorder _circularBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  );

  static final ButtonThemeData _buttonTheme = ButtonThemeData(
    shape: _circularBorder,
    height: 55,
    buttonColor: primary,
    textTheme: ButtonTextTheme.primary,
  );

  static final _fabThemeData = FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );

  static final AppBarTheme _lightAppBarTheme = AppBarTheme(
    brightness: Brightness.light,
    color: bgLight,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black87),
    textTheme: TextTheme(
      headline6: TextStyle(
        fontFamily: 'Nunito Sans',
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.w900,
      ),
    ),
  );

  static final AppBarTheme _darkAppBarTheme = AppBarTheme(
    brightness: Brightness.dark,
    color: bgDark,
    elevation: 0,
    textTheme: TextTheme(
      headline6: TextStyle(
        fontFamily: 'Nunito Sans',
        color: textLight,
        fontSize: 20,
        fontWeight: FontWeight.w900,
      ),
    ),
  );

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    accentColor: primary,
    appBarTheme: _lightAppBarTheme,
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
    buttonTheme: _buttonTheme,
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    accentColor: primary,
    appBarTheme: _darkAppBarTheme,
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
    buttonTheme: _buttonTheme,
  );
}
