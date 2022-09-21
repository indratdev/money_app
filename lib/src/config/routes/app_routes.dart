import 'package:flutter/material.dart';
import 'package:money_app/src/presentation/home/home_screen.dart';
import 'package:money_app/src/presentation/settings/setting_screen.dart';
import 'package:money_app/src/presentation/splash/splash_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String splash = '/splash';
  static const String settings = '/settings';

  Map<String, WidgetBuilder> getRoutes = {
    home: (_) => HomeScreen(),
    splash: (_) => SplashScreen(),
    settings: (_) => SettingScreen(),
  };
}
