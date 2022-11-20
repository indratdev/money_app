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

  // List<BottomMenu> items = [
  //   BottomMenu(title: 'Data Harian', icon: FontAwesomeIcons.wallet),
  //   BottomMenu(title: "Transaksi", icon: FontAwesomeIcons.plus),
  //   BottomMenu(title: 'Hutang', icon: FontAwesomeIcons.moneyBill),
  //   BottomMenu(title: 'Rekap', icon: FontAwesomeIcons.chartSimple),
  //   BottomMenu(title: 'Setting', icon: Icons.settings),
  // ];

  // List<Widget> allScreen = <Widget>[
  //   HomeScreen(),
  //   TransactionScreen(),
  //   RekapScreen(),
  //   SettingScreen(),
  // ];

  // List<BottomNavigationBarItem> getBottomMenu(List<BottomMenu> tabs) {
  //   return tabs
  //       .map(
  //         (item) => BottomNavigationBarItem(
  //           icon: Icon(item.icon),
  //           label: item.title,
  //         ),
  //       )
  //       .toList();
  // }

  // -------------------------- new
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
  List<PersistentBottomNavBarItem> navBarsItems(BuildContext context) {
    // final stateTheme = context.watch<ThemesBloc>().state.props.first.toString();
    // print(">>> stateTheme (menus) :: $stateTheme");

    return [
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.wallet),
        title: 'home'.tr(),
        activeColorPrimary: lightBlue,
        // (stateTheme == AppTheme.lightAppTheme.toString())
        //     ? lightBlue
        //     : lightMildWaters,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        // inactiveColorPrimary: (stateTheme == AppTheme.lightAppTheme.toString())
        //     ? CupertinoColors.systemGrey
        //     : Colors.black38,
        onSelectedTabPressWhenNoScreensPushed: () => context
            .read<TransactionBloc>()
            .add(ReadTransactionEvent(
                transactionDateTime: DateUtil().getCurrentDate())),
        // onPressed: (p0) =>
        //     context.read<TransactionBloc>().add(ReadTransactionEvent()),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.chartSimple),
        title: 'chart'.tr(),
        activeColorPrimary: lightBlue,
        // activeColorPrimary: (stateTheme == AppTheme.lightAppTheme.toString())
        //     ? lightBlue
        //     : lightMildWaters,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        // inactiveColorPrimary: (stateTheme == AppTheme.lightAppTheme.toString())
        //     ? CupertinoColors.systemGrey
        //     : Colors.black38,
        onSelectedTabPressWhenNoScreensPushed: () {
          // String date = dates.operationDate(selectedDate, OptionDate.month, 0);
          context.read<ChartBloc>().add(ReadChartDefaultEvent(
              transactionDateTime: DateUtil().getCurrentDate()));
        },
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.plus, color: Colors.white),
        title: 'transaction'.tr(),
        activeColorPrimary: lightBlue,
        // activeColorPrimary: (stateTheme == AppTheme.lightAppTheme.toString())
        //     ? lightPurple
        //     : redCalculation,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        onPressed: (p0) {
          PersistentNavBarNavigator.pushNewScreen(context,
              screen: TransactionScreen());
        },
        // routeAndNavigatorSettings: RouteAndNavigatorSettings(
        //   initialRoute: AppRoutes.transaction,
        // ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.bookOpen),
        title: 'report'.tr(),
        activeColorPrimary: lightBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        // activeColorPrimary: (stateTheme == AppTheme.lightAppTheme.toString())
        //     ? lightBlue
        //     : lightMildWaters,

        // inactiveColorPrimary: (stateTheme == AppTheme.lightAppTheme.toString())
        //     ? CupertinoColors.systemGrey
        //     : Colors.black38,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.android),
        title: 'titleSetting'.tr(),
        activeColorPrimary: lightBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        // activeColorPrimary: (stateTheme == AppTheme.lightAppTheme.toString())
        //     ? lightBlue
        //     : lightMildWaters,
        // inactiveColorPrimary: (stateTheme == AppTheme.lightAppTheme.toString())
        //     ? CupertinoColors.systemGrey
        //     : Colors.black38,
      ),
    ];
  }
}
