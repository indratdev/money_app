import 'package:flutter/material.dart';
import 'package:money_app/presentation/pages/settings/category/category_add_screen.dart';
import 'package:money_app/presentation/pages/settings/category/category_select_icon.dart';

import '../../presentation/moneyapp_screen.dart';
import '../../presentation/pages/home/home_screen.dart';
import '../../presentation/pages/settings/category/category_screen.dart';
import '../../presentation/pages/settings/setting_screen.dart';
import '../../presentation/pages/splash/splash_screen.dart';

class AppRoutes {
  static const String first = '/';
  static const String home = '/home';
  static const String splash = '/splash';
  static const String settings = '/settings';
  static const String settCategory = '/setting/category';
  static const String settCategoryAdd = '/setting/category/add';
  static const String settCategorySelectIcon =
      '/setting/category/add/selectIcon';

  Map<String, WidgetBuilder> getRoutes = {
    first: (_) => MoneyappScreen(),
    home: (_) => HomeScreen(),
    splash: (_) => SplashScreen(),
    settings: (_) => SettingScreen(),
    settCategory: (_) => CategoryScreen(),
    settCategoryAdd: (_) => CategoryAddScreen(),
    settCategorySelectIcon: (_) => CategorySelectIconScreen(),
  };
}
