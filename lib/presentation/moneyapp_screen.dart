import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/presentation/pages/transaction/bloc/transaction_bloc.dart';
import 'package:money_app/presentation/pages/transaction/transaction_screen.dart';
import 'package:money_app/presentation/widgets/customWidgets.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../config/menus/menus.dart';

class MoneyappScreen extends StatelessWidget {
  MoneyappScreen({Key? key}) : super(key: key);
  final menu = Menus();

  @override
  Widget build(BuildContext context) {
    int _index = 0;

    return SafeArea(
      child: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (context, state) {
          print(">>>>> state : $state");
          if (state is SuccessSaveTransactionNew) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Data Berhasil Ditambahkan")));
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
              backgroundColor: Colors.white, // Default is Colors.white.
              handleAndroidBackButtonPress: true, // Default is true.
              resizeToAvoidBottomInset:
                  true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
              stateManagement: true, // Default is true.

              hideNavigationBarWhenKeyboardShows:
                  true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
              decoration: NavBarDecoration(
                borderRadius: BorderRadius.circular(10.0),
                colorBehindNavBar: Colors.white,
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
