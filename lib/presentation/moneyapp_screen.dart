import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/config/themes/app_themes.dart';
import 'package:money_app/data/constants.dart';
import 'package:money_app/presentation/pages/settings/themes/themes_bloc/themes_bloc.dart';
import 'package:money_app/presentation/pages/transaction/bloc/transaction_bloc.dart';
import 'package:money_app/presentation/widgets/customWidgets.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../config/menus/menus.dart';
import '../data/date_util.dart';

class MoneyappScreen extends StatelessWidget {
  MoneyappScreen({Key? key}) : super(key: key);
  final menu = Menus();

  @override
  Widget build(BuildContext context) {
    int _index = 0;
    // final stateTheme = context.watch<ThemesBloc>().state.props.first.toString();

    return SafeArea(
      child: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (context, state) {
          // print(">>>>> state : $state");
          if (state is SuccessUpdateTransaction) {
            CustomWidgets.showMessageAlertBasic(
                context, 'success-update-transaction'.tr());
            context.read<TransactionBloc>().add(ReadTransactionEvent(
                transactionDateTime: DateUtil().getCurrentDate()));
          }
          if (state is SuccessDeleteTransaction) {
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text("Data Berhasil dihapus")));
            CustomWidgets.showMessageAlertBasic(
                context, 'success-delete-transaction'.tr());
          }

          if (state is SuccessSaveTransactionNew) {
            // ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text("Data Berhasil Ditambahkan")));
            CustomWidgets.showMessageAlertBasic(
                context, 'success-added-transaction'.tr());
            // }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: menu.bottomScreenMenu().elementAt(_index),
            bottomNavigationBar: PersistentTabView(
              context,
              screens: menu.bottomScreenMenu(),
              items: menu.navBarsItems(context),
              confineInSafeArea: true,
              backgroundColor: Colors.white,
              // (stateTheme == AppTheme.lightAppTheme.toString())
              // ? Colors.white
              // : lightPurple, // Default is Colors.white.
              handleAndroidBackButtonPress: true, // Default is true.
              resizeToAvoidBottomInset:
                  true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
              stateManagement: true, // Default is true.

              hideNavigationBarWhenKeyboardShows:
                  true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
              decoration: NavBarDecoration(
                borderRadius: BorderRadius.circular(10.0),
                colorBehindNavBar: Colors.white,
                adjustScreenBottomPaddingOnCurve: true,
              ),
              popAllScreensOnTapOfSelectedTab: true,

              popActionScreens: PopActionScreensType.all,
              itemAnimationProperties: const ItemAnimationProperties(
                // Navigation Bar's items animation properties.
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
              ),
              screenTransitionAnimation: const ScreenTransitionAnimation(
                // Screen transition animation on change of selected tab.
                animateTabTransition: true,
                curve: Curves.ease,
                duration: Duration(milliseconds: 200),
              ),

              navBarStyle: NavBarStyle
                  .style16, // Choose the nav bar style with this property.
            ),
          );
        },
      ),
    );
  }
}
