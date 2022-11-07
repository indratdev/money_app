import 'package:flutter/material.dart';
import 'package:money_app/presentation/pages/clear_data/cleardata_screen.dart';

import 'package:money_app/presentation/pages/settings/category/category_add_screen.dart';
import 'package:money_app/presentation/pages/settings/category/category_select_icon_screen.dart';
import 'package:money_app/presentation/pages/settings/category/category_updel_screen.dart';
import 'package:money_app/presentation/pages/settings/languanges/languange_screen.dart';
import 'package:money_app/presentation/pages/transaction/transaction_category_screen.dart';
import 'package:money_app/presentation/pages/transaction/transaction_manage_screen.dart';
import 'package:money_app/presentation/pages/transaction/transaction_screen.dart';

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
  static const String settCategoryUpDel = '/setting/category/updel';
  static const String transaction = '/transaction';
  static const String transactionIcon = '/transaction/selectIcon';
  static const String transactionCategory = '/transaction/selectCategory';
  static const String transactionManage = '/transaction/manage';
  static const String settLanguage = '/setting/language';
  static const String settClearData = '/setting/cleardata';

  Map<String, WidgetBuilder> getRoutes = {
    first: (_) => MoneyappScreen(),
    home: (_) => HomeScreen(),
    splash: (_) => SplashScreen(),
    settings: (_) => SettingScreen(),
    settCategory: (_) => CategoryScreen(),
    settCategoryAdd: (_) => CategoryAddScreen(),
    settCategorySelectIcon: (_) => CategorySelectIconScreen(),
    settCategoryUpDel: (_) => CategoryUpDelScreen(),
    transaction: (_) => TransactionScreen(),
    transactionIcon: (_) => CategorySelectIconScreen(),
    transactionCategory: (_) => TransactionCategoryScreen(),
    transactionManage: (_) => TransactionManageScreen(),
    settLanguage: (_) => LanguangeScreen(),
    settClearData: (_) => ClearDataScreen(),
  };
}
