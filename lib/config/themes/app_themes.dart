import 'package:flutter/material.dart';

import '../../data/constants.dart';

enum AppTheme {
  lightAppTheme,
  darkAppTheme,
}

final appThemeData = {
  AppTheme.darkAppTheme: ThemeData(
    scaffoldBackgroundColor: Colors.black38,
    primarySwatch: Colors.blue,
    primaryColor: Colors.black,
    backgroundColor: Colors.black,
    // colorScheme: ColorScheme(brightness: brightness, primary: primary, onPrimary: onPrimary, secondary: secondary, onSecondary: onSecondary, error: error, onError: onError, background: background, onBackground: onBackground, surface: surface, onSurface: onSurface),
    indicatorColor: Color(0xff0E1D36),
    buttonColor: Color(0xff3B3B3B),
    hintColor: Color(0xff280C0B),
    highlightColor: Color(0xff372901),
    hoverColor: Color(0xff3A3A3B),
    focusColor: Color(0xff0B2512),
    disabledColor: Colors.grey,
    // textSelectionColor:  Colors.white : Colors.black,
    cardColor: Color(0xFF151515),
    canvasColor: Colors.black,
    brightness: Brightness.dark,
    // buttonTheme: Theme.of(context).buttonTheme.copyWith(
    colorScheme: ColorScheme.dark(),
    appBarTheme: AppBarTheme(color: Colors.white, centerTitle: false),
  ),
  // primaryColor: Colors.redAccent,
  // primarySwatch: Colors.blue,
  // // unselectedWidgetColor: Colors.white,
  // textTheme: TextTheme(
  //   headline3: TextStyle().copyWith(color: Colors.white),

  AppTheme.lightAppTheme: ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.white,
    backgroundColor: Color(0xffF1F5FB),

    // unselectedWidgetColor: Colors.white,
    // colorScheme: ColorScheme(brightness: brightness, primary: primary, onPrimary: onPrimary, secondary: secondary, onSecondary: onSecondary, error: error, onError: onError, background: background, onBackground: onBackground, surface: surface, onSurface: onSurface),
    indicatorColor: Color(0xffCBDCF8),
    buttonColor: Color(0xffF1F5FB),
    hintColor: Color(0xffEECED3),
    highlightColor: Color(0xffFCE192),
    hoverColor: Color(0xff4285F4),
    focusColor: Color(0xffA8DAB5),
    disabledColor: Colors.grey,
    // textSelectionColor:  Colors.white : Colors.black,
    cardColor: Colors.white,
    canvasColor: Colors.grey[50],
    brightness: Brightness.light,
    // buttonTheme: Theme.of(context)
    //     .buttonTheme
    //     .copyWith(colorScheme: ColorScheme.light()),
    appBarTheme: AppBarTheme(color: lightBlue, centerTitle: false),
  ),
};

// extension DarkMode on BuildContext {
//   /// is dark mode currently enabled?
//   bool get isDarkMode {
//     // final brightness = MediaQuery.of(this).platformBrightness;
//     final brightness = appThemeData[].;
//     print("brightness :: $brightness");
//     print(brightness == Brightness.dark);
//     return brightness == Brightness.dark;
//   }
// }
