import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_app/data/date_util.dart';
import 'package:money_app/presentation/pages/chart/chart_screen.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../data/constants.dart';
import '../../presentation/pages/chart/bloc/chart_bloc.dart';
import '../../presentation/pages/home/home_screen.dart';
import '../../presentation/pages/rekap/rekap_screen.dart';
import '../../presentation/pages/settings/setting_screen.dart';

import '../../presentation/pages/transaction/bloc/transaction_bloc.dart';
import '../../presentation/pages/transaction/transaction_screen.dart';

class BottomMenu {
  String title;
  IconData icon;

  BottomMenu({
    required this.title,
    required this.icon,
  });
}

class Menus {
  DateUtil dates = DateUtil();

  List<Widget> bottomScreenMenu() {
    return [
      HomeScreen(),
      ChartScreen(),
      TransactionScreen(),
      RekapScreen(),
      SettingScreen(),
    ];
  }

  //
  List<PersistentBottomNavBarItem> navBarsItems(
      BuildContext context, Brightness brightness) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.wallet),
        title: 'home'.tr(),
        activeColorPrimary: lightBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        onSelectedTabPressWhenNoScreensPushed: () => context
            .read<TransactionBloc>()
            .add(ReadTransactionEvent(
                transactionDateTime: DateUtil().getCurrentDate())),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.chartSimple),
        title: 'chart'.tr(),
        activeColorPrimary: lightBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        onSelectedTabPressWhenNoScreensPushed: () {
          context.read<ChartBloc>().add(ReadChartDefaultEvent(
              transactionDateTime: DateUtil().getCurrentDate()));
        },
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.plus, color: Colors.white),
        title: 'transaction'.tr(),
        activeColorPrimary: bluePaypal,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        onPressed: (p0) {
          PersistentNavBarNavigator.pushNewScreen(context,
              screen: TransactionScreen());
        },
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.bookOpen),
        title: 'report'.tr(),
        activeColorPrimary: lightBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.android),
        title: 'titleSetting'.tr(),
        activeColorPrimary: lightBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
