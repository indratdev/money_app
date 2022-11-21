import 'package:flutter/material.dart';

import '../../data/constants.dart';

enum AppTheme {
  lightAppTheme,
  darkAppTheme,
}

final appThemeData = {
  AppTheme.darkAppTheme: ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black38,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      color: charcoal,
      centerTitle: false,
    ),
    // primarySwatch: Colors.blue,
    // primaryColor: Colors.black,
    // backgroundColor: Colors.black,

    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      primary: const Color(0xffbb86fc),
      onPrimary: Colors.black,
      secondary: const Color(0xff03dac6),
      onSecondary: Colors.black,
      error: const Color(0xffcf6679),
      onError: Colors.black,
      background: const Color(0xff121212),
      onBackground: Colors.white,
      surface: const Color(0xff121212),
      onSurface: Colors.white,
    ),
    dividerColor: Colors.white,
    // indicatorColor: Color(0xff0E1D36),
    // buttonColor: Color(0xff3B3B3B),
    // hintColor: Color(0xff280C0B),
    // highlightColor: Color(0xff372901),
    // hoverColor: Color(0xff3A3A3B),
    // focusColor: Color(0xff0B2512),
    // disabledColor: Colors.grey,
    // // textSelectionColor:  Colors.white : Colors.black,
    // cardColor: Color(0xFF151515),
    // canvasColor: Colors.black,

    // buttonTheme: Theme.of(context).buttonTheme.copyWith(

    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: lightPurple),

    // bottomNavigationBarTheme:
    //     BottomNavigationBarThemeData(backgroundColor: Colors.amber),

    // textTheme: TextTheme()
    // textTheme: TextTheme()
    // primaryTextTheme: TextTheme(titleSmall: TextStyle(color: Colors.amber)),
  ),
  // primaryColor: Colors.redAccent,
  // primarySwatch: Colors.blue,
  // // unselectedWidgetColor: Colors.white,
  // textTheme: TextTheme(
  //   headline3: TextStyle().copyWith(color: Colors.white),

  AppTheme.lightAppTheme: ThemeData.light().copyWith(
    brightness: Brightness.light,
    // primarySwatch: Colors.indigo,
    primaryColor: Colors.white,
    backgroundColor: Color(0xffF1F5FB),
    dividerColor: blackDefault,

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
