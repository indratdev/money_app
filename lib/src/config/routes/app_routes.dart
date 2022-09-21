import 'package:flutter/material.dart';
import 'package:money_app/src/presentation/home/home_screen.dart';
import 'package:money_app/src/presentation/moneyapp_screen.dart';
import 'package:money_app/src/presentation/settings/setting_screen.dart';
import 'package:money_app/src/presentation/splash/splash_screen.dart';

class AppRoutes {
  static const String first = '/';
  static const String home = '/home';
  static const String splash = '/splash';
  static const String settings = '/settings';
  static const String settCategory = '/setting/category';

  Map<String, WidgetBuilder> getRoutes = {
    first: (_) => MoneyappScreen(),
    home: (_) => HomeScreen(),
    splash: (_) => SplashScreen(),
    settings: (_) => SettingScreen(),
    // settCategory : (_) =>
  };
}
