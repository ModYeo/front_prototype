import 'package:flutter/material.dart';

const rad = Radius.circular(25);
var defaultBorderRadius = const BorderRadius.only(
    topLeft: rad,
    topRight: rad,
    bottomRight: rad
);

var mainColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xffdae4d3),
    onPrimary: Color(0xff707070),
    secondary: Color(0xffd8e8d7),
    onSecondary: Color(0xff707070),
    tertiary: Color(0xfff2f6f0),
    onTertiary: Color(0xffffffff),
    error: Color(0xffffffff),
    onError: Color(0xff000000),
    background: Color(0xffffffff),
    onBackground: Color(0xff6a9070),
    surface: Color(0xffffffff),
    onSurface: Color(0xff6a9070)
);

var mainTheme = ThemeData(
  useMaterial3: true,
  colorScheme: mainColorScheme,
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: mainColorScheme.primary,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),//defaultBorderRadius,
      borderSide: const BorderSide(width: 0, style: BorderStyle.none),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: mainColorScheme.secondary,
      onPrimary: mainColorScheme.onSecondary,
      onSurface: Colors.white,
    )
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: mainColorScheme.secondary,
      onSurface: Colors.white,
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      surfaceTintColor: Colors.white,
      enableFeedback: false
    )
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: false,
    showSelectedLabels: false,
    selectedItemColor: Colors.green,
  )
);